const ParkingEvent = require('../models/ParkingEvent');

// Get all parking events
exports.getParkingEvents = async (req, res) => {
  try {
    const parkingEvents = await ParkingEvent.find();
    res.status(200).json(parkingEvents);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

// Get parking events by number plate
exports.getParkingEventsByNumberPlate = async (req, res) => {
  try {
    const number_Plate = req.query.number_plate;
    const parkingEvents = await ParkingEvent.find({ number_plate: number_Plate });

    if (!parkingEvents.length) {
      return res.status(404).json({ message: 'No parking events found for this number plate' });
    }

    res.status(200).json(parkingEvents);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};
