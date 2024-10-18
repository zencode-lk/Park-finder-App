const express = require('express');
const { getParkingEvents, getParkingEventsByNumberPlate } = require('../controllers/parkingEventController');

const router = express.Router();

// Route to get all parking events
router.get('/', getParkingEvents);

// Route to get parking events by number plate
router.get('/search', getParkingEventsByNumberPlate);

module.exports = router;
