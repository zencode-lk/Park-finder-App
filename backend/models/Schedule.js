const mongoose = require('mongoose');

// Define the Schedule schema
const scheduleSchema = new mongoose.Schema({
    landId: { type: mongoose.Schema.Types.ObjectId, ref: 'Land', required: true },
    userId: { type: mongoose.Schema.Types.ObjectId, ref: 'User', required: true },
    date: { type: Date, required: true }, 
    startTime: { type: Date, required: true }, 
    endTime: { type: Date, required: true },    
    fee : {type: Number, required: true}
});

// Export the Schedule model
module.exports = mongoose.model('Schedule', scheduleSchema, 'schedule');
