const mongoose = require('mongoose');

const LandSchema = new mongoose.Schema({
    ownerFullName: {type:String, required:true},
    landLocation: {type:String}
})