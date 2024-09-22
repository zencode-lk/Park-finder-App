const Vehicle = require('../models/Vehicle');

// Register a vehicle for a user
exports.registerVehicle = async (req, res) => {
  try {
    const { make, model, plateNumber, userId } = req.body;

    const vehicle = new Vehicle({
      make,
      model,
      plateNumber,
      userId // Reference to the user
    });

    const savedVehicle = await vehicle.save();
    res.status(201).json({ message: 'Vehicle registered', vehicle: savedVehicle });
  } catch (error) {
    res.status(400).json({ message: error.message });
  }
};

// Get vehicles for a specific user
exports.getVehiclesByUserId = async (req, res) => {
  try {
    const userId = req.params.userId;
    const vehicles = await Vehicle.find({ userId });
    res.status(200).json(vehicles);
  } catch (error) {
    res.status(400).json({ message: error.message });
  }
};
