const Vehicle = require('../models/Vehicle');
const User = require('../models/User');

// Register a vehicle for a user
exports.registerVehicle = async (req, res) => {
  try {
    const { make, model, plateNumber, nic } = req.body;

    const vehicle = new Vehicle({
      make,
      model,
      plateNumber,
      nic // Reference to the user
    });

    const savedVehicle = await vehicle.save();
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
exports.getUserByVehiclePlate = async (req, res) => {
    try {
      const { plateNumber } = req.params;
      
      // Find the vehicle by plate number
      const vehicle = await Vehicle.findOne({ plateNumber });
      
      if (!vehicle) {
        return res.status(404).json({ message: "Vehicle not found" });
      }
      
      // Find the user associated with the vehicle
      const user = await User.findOne({ _id: vehicle.userId });
      
      if (!user) {
        return res.status(404).json({ message: "User not found" });
      }
      
      res.status(200).json(user); // Return the user details
    } catch (error) {
      res.status(500).json({ message: error.message });
    }
  };
  