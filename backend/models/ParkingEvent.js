const mongoose = require('mongoose');

const ParkingEventSchema = new mongoose.Schema({
  number_plate: { type: String, required: true },
  parking_cost: { type: mongoose.Types.Decimal128, required: true },
  detected_time: { type: Date, required: true },
  // Add more fields as needed
});

module.exports = mongoose.model('ParkingEvent', ParkingEventSchema, 'parkingEvents');
