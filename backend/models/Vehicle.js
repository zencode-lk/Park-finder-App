const mongoose = require('mongoose');

const VehicleSchema = new mongoose.Schema({
  make: { type: String, required: true },
  model: { type: String, required: true },
  plateNumber: { type: String, required: true },
  userId: {
    type: String,
    ref: 'User', // Reference to User model
    required: true
  }
});

module.exports = mongoose.model('Vehicle', VehicleSchema);
