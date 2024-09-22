// controllers/placeController.js
const axios = require('axios');

const API_KEY = process.env.GOOGLE_MAPS_API_KEY;

const getNearbyPlaces = async (req, res) => {
  const { location, radius } = req.query;

  try {
    const response = await axios.get(`https://maps.googleapis.com/maps/api/place/nearbysearch/json`, {
      params: {
        location,
        radius,
        type: 'parking',
        key: API_KEY,
      },
    });

    res.json(response.data);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

module.exports = {
  getNearbyPlaces,
};
