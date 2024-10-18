const express = require('express');
const {
  registerUser,
  loginUser,
  getUsers,
  getUserById,
  getPaymentHistoryByPlate, // Add the new controller function
} = require('../controllers/userController');

const router = express.Router();

router.post('/register', registerUser);           // Register a new user
router.post('/login', loginUser);                 // Login user
router.get('/', getUsers);                        // Get all users
router.get('/:userId', getUserById);              // Get user by ID

// Route to get payment history by vehicle number plate
router.get('/payment-history', getPaymentHistoryByPlate); // Add this line

module.exports = router;
