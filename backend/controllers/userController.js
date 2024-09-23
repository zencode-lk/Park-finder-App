const User = require('../models/User');
const Vehicle = require('../models/Vehicle');
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

    if (!user || !(await bcrypt.compare(password, user.password))) {
      return res.status(401).json({ message: 'Invalid credentials' });
    }
    
    if (user.userType == 'landowner') {
        const token = jwt.sign({ id: user._id }, process.env.JWT_SECRET, { expiresIn: '14d' });
        res.status(200).json({ message: 'Login successful', token });
    } else {
        const token = jwt.sign({ id: user._id }, process.env.JWT_SECRET, { expiresIn: '14d' });
        res.status(200).send({ dashboard: 'normal', token });
    }
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
exports.getUserVehicles = async (req, res) => {
    const { nic } = req.params;
    try {
      const user = await User.findOne({ nic }).populate('vehicles');
      if (!user) {
        return res.status(404).json({ message: 'User not found' });
      }
      res.status(200).json(user.vehicles); // Send vehicles
    } catch (error) {
      res.status(500).json({ message: error.message });
    }
  };