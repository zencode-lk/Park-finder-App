const mongoose = require('mongoose');

// Define the address schema
const addressSchema = new mongoose.Schema({
    streetNo: { type: String, required: true },
    road: { type: String, required: true },
    city: { type: String, required: true },
});

// Define the land schema
const LandSchema = new mongoose.Schema({
    landLocation: { type: addressSchema, required: true },
    ownerContact: { type: Number, required: true },
    noParkingSlot: { type: Number, required: true },
    availableSlot: { type: Number } // Remove required: true
});

// Pre-save hook to set availableSlot to noParkingSlot
LandSchema.pre('save', function(next) {
    this.availableSlot = this.noParkingSlot; // Set availableSlot to noParkingSlot
    next();
});

// Create the model
const Land = mongoose.model('Land', LandSchema, 'landOwners');

module.exports = Land;
