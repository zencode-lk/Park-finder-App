const mongoose = require('mongoose');

// Define the address schema
const addressSchema = new mongoose.Schema({
    streetNo: { type: String, required: true },
    road: { type: String, required: true },
    city: { type: String, required: true },
});

// Define the land schema
const landSchema = new mongoose.Schema({
    landLocation: { type: addressSchema, required: true },
    landName: { type: String, required: true },
    ownerContact: { type: Number, required: true },
    noParkingSlot: { type: Number, required: true },
    availableSlot: { type: Number }, // Set during save
    noReserveSlot: { type: Number, required: true },
    availableReserveSlot: { type: Number }, //set during save
});

// Pre-save hook to set availableSlot and availableReserveSlot only during creation
landSchema.pre('save', function (next) {
    // Only set availableSlot and availableReserveSlot if it's a new document
    if (this.isNew) {
        this.availableSlot = this.noParkingSlot;
        this.availableReserveSlot = this.noReserveSlot;
    }
    next();
});

const Land = mongoose.model('Land', landSchema, 'landOwners');

module.exports = Land;
