const Schedule = require('../models/Schedule');
const Land = require('../models/Land');
const User = require('../models/User');
const { sendBookingConfirmationEmail } = require('./emailController');

const releaseEndedSchedules = async () => {
    try {
        const currentTime = new Date();

        const endedSchedules = await Schedule.find({
            endTime: { $lte: currentTime }
        });

        for (const schedule of endedSchedules) {
            const land = await Land.findById(schedule.landId);
            if (land) {
                land.availableReserveSlot++;
                await land.save();
                await Schedule.deleteOne({ _id: schedule._id });
                console.log(`Slot released for land ID: ${schedule.landId}, Schedule ID: ${schedule._id}`);
            }
        }
    } catch (error) {
        console.error('Error releasing ended schedules:', error);
    }
};

const startSlotReleaseJob = () => {
    const releaseInterval = 60 * 1000; // 1 minute
    setInterval(async () => {
        console.log('Checking for ended schedules...');
        await releaseEndedSchedules();
    }, releaseInterval);
};

// Schedule creation logic
const createSchedule = async (req, res) => {
    try {
        const { landId, userId, date, startTime, endTime, fee } = req.body;

        console.log(`Creating schedule with startTime: ${startTime}, endTime: ${endTime}`);

        const land = await Land.findById(landId);
        if (!land) {
            return res.status(404).json({ message: 'Land not found' });
        }

        const totalSlots = land.availableReserveSlot;
        const activeReservations = await Schedule.find({
            landId,
            $or: [
                { startTime: { $lt: endTime }, endTime: { $gt: startTime } },
            ],
        });

        if (activeReservations.length >= totalSlots) {
            return res.status(400).json({ message: 'No available slots for the selected time' });
        }

        const newSchedule = new Schedule({
            landId,
            userId,
            date,
            startTime,
            endTime,
            fee,
        });

        await newSchedule.save();

        land.availableReserveSlot--;
        await land.save();

        console.log(`New schedule created for land ID: ${landId}, Slots remaining: ${land.availableReserveSlot}`);

        const user = await User.findById(userId);
       
        if (!user) {
            return res.status(404).json({ message: 'User not found' });
        }

        // Deduct booking fee after creating the schedule
        if (user.userAcc < fee) {
            return res.status(400).json({ message: 'Insufficient balance for booking' });
        }
        user.userAcc -= fee; 
        await user.save(); 

        console.log(`Booking fee deducted: $${fee}, User's new balance: ${user.userAcc}`);
        console.log('User account balance before deduction:', user.userAcc);
        console.log('Type of userAcc:', typeof user.userAcc);

        // Send confirmation email
        await sendBookingConfirmationEmail(user.email, {
            landName: land.landName,
            date,
            startTime,
            endTime,
            fee,
        });

        return res.status(201).json({
            message: 'Schedule created successfully, booking fee deducted',
            schedule: newSchedule,
            bookingFee: fee,
            userBalance: user.userAcc,
        });
    } catch (error) {
        console.error('Error creating schedule:', error);
        return res.status(500).json({ message: 'Server error', error: error.message });
    }
};

startSlotReleaseJob();

// Controller to fetch schedules by userId
const getProfileSchedules = async (req, res) => {
  const { userId } = req.params;

  try {
    const schedules = await Schedule.find({ userId: userId });

    if (!schedules || schedules.length === 0) {
      return res.status(404).json({ message: 'No schedules found for this user.' });
    }
    res.status(200).json(schedules);
  } catch (error) {
    console.error('Error fetching schedules:', error);
    res.status(500).json({ message: 'Internal server error.' });
  }
};


module.exports = { createSchedule,  getProfileSchedules };
