const User = require('../models/User');
const Vehicle = require('../models/Vehicle');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');

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

exports.loginUser = async (req, res) => {
    try {
      const { email, password } = req.body;
      const user = await User.findOne({ email });
       
      if (!user || !(await bcrypt.compare(password, user.password))) {
        return res.status(401).json({ message: 'Invalid credentials' });
      }
  
      // Generate a token based on user type
      const token = jwt.sign({ id: user._id, userType: user.userType }, process.env.JWT_SECRET, { expiresIn: '14d' });
  
      res.status(200).json({
        id : user._id,
        message: 'Login successful',
        token,
        userType: user.userType, 
        ...(user.userType === 'landowner' ? {} : { dashboard: 'normal' }),// add dashboard info based on userType
        
      });
    } catch (error) {
      res.status(400).json({ message: error.message });
    }
  };
  
exports.getUsers = async (req, res) => {
  try {
    const users = await User.find();
    res.status(200).json(users);
  } catch (error) {
    res.status(400).json({ message: error.message });
  }
};

exports.userProfile = async (req, res) => {
  try {
    const userID = req.params.id;  

    if (!mongoose.Types.ObjectId.isValid(userID)) {
      return res.status(400).json({ message: "Invalid user ID" });
    }

    const user = await User.findById(userID);  

    if (!user) {
      return res.status(404).json({ message: "User not found" });
    }

    res.status(200).json(user);  
  } catch (error) {
    res.status(500).json({ message: error.message });  
  }
};
