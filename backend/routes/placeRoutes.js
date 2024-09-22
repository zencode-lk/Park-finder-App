// routes/placeRoutes.js
const express = require('express');
const { getNearbyPlaces } = require('../controllers/placeController');

const router = express.Router();

// Define route for fetching nearby places
router.get('/', getNearbyPlaces);

module.exports = router;
