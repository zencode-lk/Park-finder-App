const User = require('../models/User');
const Land = mongoose.model('Land', LandSchema);
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');

exports.registerLand = async (req, res) => {
  try {
    const { landLocation, ownerContact, noParkingSlot } = req.body;

    // Create new land
    const newLand = new Land({
      landLocation, // landLocation is an object containing streetNo, road, city
      ownerContact,
      noParkingSlot
    });

    // Save land to database
    const savedLand = await newLand.save();
    res.status(201).json({ message: 'Land created successfully', land: savedLand });
  } catch (error) {
    res.status(500).json({ message: 'Error creating land', error: error.message });
  }
};
exports.registerLandOwner = async (req, res) => {
    try {
      const { firstName, lastName, userName, email, nic, password, userType, landData } = req.body;
  
      // Check if userType is 'landowner', and if so, handle accordingly
      if (userType !== 'landowner') {
        return res.status(400).json({ message: 'Invalid user type. Only landowners can register here.' });
      }
  
      // Hash the password
      const hashedPassword = await bcrypt.hash(password, 10);
  
      // Create a new User with userType set to 'landowner'
      const newUser = new User({
        firstName,
        lastName,
        userName,
        email,
        nic,
        password: hashedPassword,
        userType: 'landowner',
      });
  
      // Save the user first
      await newUser.save();
  
      // Now, handle land registration. Multiple lands can be registered.
      const registeredLands = [];
  
      // Assuming landData is an array of lands to be registered by the user
      for (const land of landData) {
        const newLand = new Land({
          ownerFullName: `${firstName} ${lastName}`,
          landLocation: land.landLocation,
          ownerContact: land.ownerContact,
          noParkingSlot: land.noParkingSlot,
        });
  
        const savedLand = await newLand.save();
  
        // Push saved land ID into the user's lands array
        registeredLands.push(savedLand._id);
      }
  
      // Now update the user's lands array with the newly created land IDs
      newUser.lands = registeredLands;
      await newUser.save(); // Save user with updated lands
  
      // Respond to the client
      res.status(201).json({
        message: 'Landowner registered successfully',
        userId: newUser._id,
        lands: registeredLands,
      });
    } catch (error) {
      console.error(error);
      res.status(400).json({ message: error.message });
    }
  };