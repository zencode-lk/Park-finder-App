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
       
      // Check if the user exists and the password is correct
      if (!user || !(await bcrypt.compare(password, user.password))) {
        return res.status(401).json({ message: 'Invalid credentials' });
      }
  
      // Generate a token based on user type
      const token = jwt.sign({ id: user._id, userType: user.userType }, process.env.JWT_SECRET, { expiresIn: '14d' });
  
      // Send the response with the token and user type
      res.status(200).json({
        id : user._id,
        message: 'Login successful',
        token,
        userType: user.userType, // Include userType in the response
        ...(user.userType === 'landowner' ? {} : { dashboard: 'normal' }),// add dashboard info based on userType
        
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


  