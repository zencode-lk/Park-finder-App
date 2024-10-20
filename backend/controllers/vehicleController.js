const Vehicle = require('../models/Vehicle');
const User = require('../models/User');

exports.registerVehicle = async (req, res) => {
  try {
    const { make, model, plateNumber, userId } = req.body; 

    // Create a new vehicle instance
    const vehicle = new Vehicle({
      make,
      model,
      plateNumber,
      id: userId 
    });

    const savedVehicle = await vehicle.save();
    await User.findByIdAndUpdate(
      userId, 
      { $push: { vehicles: savedVehicle._id } }, 
      { new: true } 
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

exports.getUserByPlateNumber = async (req, res) => {
  const { plateNumber } = req.params;

  try {
      const vehicle = await Vehicle.findOne({ plateNumber });

      if (!vehicle) {
          return res.status(404).json({ message: 'Vehicle not found' });
      }

      // Get the user associated with the vehicle using vehicle.id
      const user = await User.findById(vehicle.id); 
      if (!user) {
          return res.status(404).json({ message: 'User not found' });
      }

      res.status(200).json(user); 
  } catch (error) {
      res.status(500).json({ message: error.message });
  }
};
