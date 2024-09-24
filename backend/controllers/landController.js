const User = require('../models/User'); // Assuming user model is imported
const Land = require('../models/Land');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');

exports.registerLandOwner = async (req, res) => {
  try {
    const { firstName, lastName, userName, email, nic, password, userType, land } = req.body;
    
    // Create new land entry
    const newLand = new Land({
      landLocation: land.landLocation,
      ownerContact: land.ownerContact,
      noParkingSlot: land.noParkingSlot,
    });
    const savedLand = await newLand.save();

    // Hash password
    const hashedPassword = await bcrypt.hash(password, 10);

    // Create new user and associate land
    const newUser = new User({
      firstName,
      lastName,
      userName,
      email,
      nic,
      password: hashedPassword,
      userType: 'landowner',
      lands: [savedLand._id], // Reference the land ID
    });

    const savedUser = await newUser.save();

    res.status(201).json({ message: 'Landowner registered', userId: savedUser._id });
  } catch (error) {
    res.status(400).json({ message: error.message });
  }
};
