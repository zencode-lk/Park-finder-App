const express = require('express');
const { getNearbyPlaces } = require('../controllers/placeController');

const router = express.Router();

router.get('/', getNearbyPlaces);

module.exports = router;
