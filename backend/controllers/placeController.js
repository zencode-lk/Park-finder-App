// controllers/placeController.js
const axios = require('axios');

const API_KEY = process.env.GOOGLE_MAPS_API_KEY;

exports.getNearbyPlaces = async (req, res) => {
  const { location, radius = 1000 } = req.query;

  try {
    let locationCoordinates;

    // Check if location is a string (like a city) or coordinates
    if (isNaN(location.split(',')[0])) {
      // If location is not in lat,lng format, treat it as a city/place and get coordinates
      const geocodeResponse = await axios.get(`https://maps.googleapis.com/maps/api/geocode/json`, {
        params: {
          address: location,
          key: API_KEY, // Ensure API key is passed correctly
        },
      });

      const { results } = geocodeResponse.data;

      if (results.length === 0) {
        return res.status(404).json({ error: 'Location not found' });
      }

      locationCoordinates = `${results[0].geometry.location.lat},${results[0].geometry.location.lng}`;
    } else {
      // If location is already lat,lng, use it as is
      locationCoordinates = location;
    }

    // Now proceed with the nearby search
    const response = await axios.get(`https://maps.googleapis.com/maps/api/place/nearbysearch/json`, {
      params: {
        location: locationCoordinates,
        radius,
        type: 'parking',
        key:API_KEY, // Ensure API key is passed correctly
      },
    });

    res.json(response.data);
  } catch (error) {
    console.error('Error fetching places:', error.message); // Log the actual error
    res.status(500).json({ error: error.message });
  }
};