const express = require('express');
const router = express.Router();
const { getVehiclesByUserId } = require('../controllers/vehicleController');

// Define route to get vehicles by user ID
router.get('/user/:userId', getVehiclesByUserId);

module.exports = router;
