const express = require('express');
const { registerLandOwner } = require('../controllers/landController');
const router = express.Router();

router.post('/register-owner', registerLandOwner);

module.exports = router;