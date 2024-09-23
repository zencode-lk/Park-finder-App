const mongoose = require('mongoose');

const UserSchema = new mongoose.Schema({
  firstName: { type: String, required: true },
  lastName: { type: String, required: true },
  userName: { type: String, required: true },
  email: { type: String, required: true, unique: true },
  nic: { type: String, required: true, unique: true },
  password: { type: String, required: true },
  vehicles: [{ type: mongoose.Schema.Types.ObjectId, ref: 'Vehicle' }] // Reference to Vehicle model
});

module.exports = mongoose.model('User', UserSchema, 'users');
