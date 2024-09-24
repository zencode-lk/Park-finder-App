const express = require('express');
const { registerVehicle, getVehicle, getUserByPlateNumber } = require('../controllers/vehicleController');

const router = express.Router();


router.post('/register', registerVehicle);  
router.get('/', getVehicle);           
router.get('/:plateNumber/user', getUserByPlateNumber); // Get vehicles by userId

module.exports = router;
