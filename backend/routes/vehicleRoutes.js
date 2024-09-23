const express = require('express');
const { registerVehicle, getUserByVehiclePlate, getVehicle } = require('../controllers/vehicleController');

const router = express.Router();

router.post('/register', registerVehicle);  
router.post('/', getVehicle);           
router.get('/:plateNumber/user', getUserByVehiclePlate); // Get vehicles by userId

module.exports = router;
