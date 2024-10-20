const express = require('express');
const { getNearbyPlaces } = require('../controllers/placeController');
const landController = require('../controllers/landController')
const router = express.Router();


router.get('/', getNearbyPlaces);
router.get('/local', landController.getPlacesByCity);
module.exports = router;
