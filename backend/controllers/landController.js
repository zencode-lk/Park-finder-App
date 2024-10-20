const User = require('../models/User');
const Land = require('../models/Land');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');

exports.registerLandOwner = async (req, res) => {
  try {
    const { firstName, lastName, userName, email, nic, password, userType, land } = req.body;

   
    console.log("noReserveSlot: ", land.noReserveSlot); 
    console.log("availableReserveSlot: ", land.availableReserveSlot); 
    
    // Create new land entry
    const newLand = new Land({
      landLocation: land.landLocation,
      landName: land.landName,
      ownerContact: land.ownerContact,
      noParkingSlot: land.noParkingSlot,
      noReserveSlot: land.noReserveSlot,  
      availableReserveSlot: land.availableReserveSlot 
    });

    const savedLand = await newLand.save();

    const hashedPassword = await bcrypt.hash(password, 10);

    // Create new user and associate land with the user
    const newUser = new User({
      firstName,
      lastName,
      userName,
      email,
      nic,
      password: hashedPassword,
      userType: 'landowner',
      lands: [savedLand._id], // Reference the saved land ID
    });

    const savedUser = await newUser.save();

    res.status(201).json({ message: 'Landowner registered successfully', userId: savedUser._id });
  } catch (error) {
    res.status(400).json({ message: error.message });
  }
};
exports.getPlacesByCity = async (req, res) => {
  const city = req.query.city;
  
  if (!city) {
      return res.status(400).json({ message: 'City is required' });
  }

  try {
      // Fetch lands based on the city
      const places = await Land.find({ 'landLocation.city': city });

      if (!places || places.length === 0) {
          return res.status(404).json({ message: `No places found in ${city}` });
      }

      res.status(200).json({ results: places });
  } catch (error) {
      console.error('Error fetching places:', error.message);
      res.status(500).json({ message: 'Internal Server Error' });
  }
};
