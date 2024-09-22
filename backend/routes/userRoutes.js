const express = require('express');
const { registerUser, loginUser, getUsers, getUserWithVehicles } = require('../controllers/userController');

const router = express.Router();

router.post('/register', registerUser);   // Register a new user
router.post('/login', loginUser);         // Login user
router.get('/', getUsers);                // Get all users
router.get('/:userId', getUserWithVehicles);  

module.exports = router;
