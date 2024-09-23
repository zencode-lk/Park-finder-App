const mongoose = require('mongoose');

const  addressSchema = new mongoose.Schema({
    streetNo: { type: String, required: true},
    road: { type, String, require: true},
    city: { type: String, required: true},
});

const LandSchema = new mongoose.Schema({
    landLocation: { type: addressSchema, required: true},
    ownerContact: { type: Number, required: true},
    noParkingSlot: { type: Number, required: true},
});

const Land = mongoose.model('Land', LandSchema, 'landOwners');
module.exports = Land;