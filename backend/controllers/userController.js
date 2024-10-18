const User = require('../models/User');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');

// Register a new user
exports.registerUser = async (req, res) => {
  try {
    const { firstName, lastName, userName, email, nic, password, userType } = req.body;
    const hashedPassword = await bcrypt.hash(password, 10);
    const newUser = new User({ firstName, lastName, userName, email, nic, password: hashedPassword, userType });
    await newUser.save();
    res.status(201).json({ message: 'User registered', userId: newUser._id });
  } catch (error) {
    res.status(400).json({ message: error.message });
  }
};

// User login
exports.loginUser = async (req, res) => {
  try {
    const { email, password } = req.body;
    const user = await User.findOne({ email });

    // Check if the user exists and the password is correct
    if (!user || !(await bcrypt.compare(password, user.password))) {
      return res.status(401).json({ message: 'Invalid credentials' });
    }

    // Generate a token based on user type
    const token = jwt.sign({ id: user._id, userType: user.userType }, process.env.JWT_SECRET, { expiresIn: '14d' });

    // Send the response with the token and user type
    res.status(200).json({
      id: user._id,
      message: 'Login successful',
      token,
      userType: user.userType,
    });
  } catch (error) {
    res.status(400).json({ message: error.message });
  }
};

// Get all users
exports.getUsers = async (req, res) => {
  try {
    const users = await User.find();
    res.status(200).json(users);
  } catch (error) {
    res.status(400).json({ message: error.message });
  }
};

exports.getUserById = async (req, res) => {
  try {
    const { userId } = req.params;
    const user = await User.findById(userId);

    if (!user) {
      return res.status(404).json({ message: 'User not found' });
    }

    // Convert Decimal128 to a plain number
    user.userAcc = user.userAcc ? user.userAcc.toString() : "0";

    res.status(200).json(user);
  } catch (error) {
    res.status(400).json({ message: error.message });
  }
};



const ParkingEvent = require('../models/ParkingEvent'); // Assuming you have this model

// Fetch payment history by vehicle number plate
exports.getPaymentHistoryByPlate = async (req, res) => {
  try {
    const { number_plate } = req.query;

    // Ensure that number_plate is provided in the query
    if (!number_plate) {
      return res.status(400).json({ message: 'Number plate is required' });
    }

    // Find parking events by the number plate
    const parkingEvents = await ParkingEvent.find({ number_plate });

    if (!parkingEvents || parkingEvents.length === 0) {
      return res.status(404).json({ message: 'No payment history found for this vehicle' });
    }

    res.status(200).json(parkingEvents);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};



