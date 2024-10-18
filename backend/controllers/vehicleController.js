const Vehicle = require('../models/Vehicle');
const User = require('../models/User');

// Register a vehicle for a user

exports.registerVehicle = async (req, res) => {
  try {
    const { make, model, plateNumber, userId } = req.body; // Use userId to associate the vehicle

    // Create a new vehicle instance
    const vehicle = new Vehicle({
      make,
      model,
      plateNumber,
      id: userId 
    });

    // Save the vehicle to the database
    const savedVehicle = await vehicle.save();

    // Now push the vehicle's ObjectId into the user's vehicles array
    await User.findByIdAndUpdate(
      userId, // Find the user by their ObjectId
      { $push: { vehicles: savedVehicle._id } }, // Push the saved vehicle's ObjectId into the vehicles array
      { new: true } // Return the updated user document
    );

    res.status(201).json({ message: 'Vehicle registered', vehicle: savedVehicle });
  } catch (error) {
    res.status(400).json({ message: error.message });
  }
};


exports.getVehicle = async (req, res) => {
    try {
      const vehicles = await Vehicle.find();
      res.status(200).json(vehicles);
    } catch (error) {
      res.status(400).json({ message: error.message });
    }
  };
// Get vehicles for a specific user
exports.getUserByPlateNumber = async (req, res) => {
  const { plateNumber } = req.params;

  try {
      // Find the vehicle using the plate number
      const vehicle = await Vehicle.findOne({ plateNumber });

      if (!vehicle) {
          return res.status(404).json({ message: 'Vehicle not found' });
      }

      // Get the user associated with the vehicle using vehicle.id
      const user = await User.findById(vehicle.id); // Assuming 'id' in the vehicle model is referencing the user's ObjectId

      if (!user) {
          return res.status(404).json({ message: 'User not found' });
      }

      res.status(200).json(user); // Send user info
  } catch (error) {
      res.status(500).json({ message: error.message });
  }
};








const mongoose = require('mongoose');
const ObjectId = mongoose.Types.ObjectId;

const getVehiclesByUserId = async (req, res) => {
  try {
    const { userId } = req.params;

    // Log userId to check if it's passed correctly
    console.log("User ID received:", userId);

    // Ensure userId is a valid ObjectId
    if (!ObjectId.isValid(userId)) {
      return res.status(400).json({ message: 'Invalid user ID format' });
    }

    // Instantiate ObjectId with 'new'
    const vehicles = await Vehicle.find({ id: new ObjectId(userId) });

    if (!vehicles || vehicles.length === 0) {
      return res.status(404).json({ message: 'No vehicles found for this user.' });
    }

    return res.status(200).json(vehicles);
  } catch (error) {
    // Log the full error to the console for debugging
    console.error("Error occurred while fetching vehicles:", error);

    // Send error details in response
    return res.status(500).json({ message: 'Server error', error: error.message });
  }
};

module.exports = {
  getVehiclesByUserId,
};

