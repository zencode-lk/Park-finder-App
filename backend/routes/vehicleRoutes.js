const express = require('express');
const { registerVehicle, getVehiclesByUserId } = require('../controllers/vehicleController');

const router = express.Router();

router.post('/register', registerVehicle);            // Register vehicle
router.get('/:userId/vehicles', getVehiclesByUserId); // Get vehicles by userId

module.exports = router;
