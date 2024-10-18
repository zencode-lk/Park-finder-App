const mongoose = require('mongoose');

const vehicleSchema = new mongoose.Schema({
  make: { type: String, required: true },
  model: { type: String, required: true },
  plateNumber: { type: String, required: true, unique: true },
  id: { type: mongoose.Schema.Types.ObjectId, ref: 'user', required: true } // Ensure this is defined correctly
});

const Vehicle = mongoose.model('Vehicle', vehicleSchema);
module.exports = Vehicle;
