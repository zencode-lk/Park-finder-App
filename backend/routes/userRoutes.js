const express = require('express');
const { registerUser, loginUser, getUsers, getUserVehicles } = require('../controllers/userController');
const router = express.Router();

router.post('/register', registerUser);   // Register a new user
router.post('/login', loginUser);         // Login user
router.get('/', getUsers);                // Get all users
// router.get('/:id/vehicles', getUserVehicles); // Get vehicles by user's NIC

module.exports = router;
