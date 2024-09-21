const axios = require('axios');

exports.getNearbyPlaces = async (req, res) => {
    const { location, radius, key } = req.query;
    try {
        const response = await axios.get(`https://maps.googleapis.com/maps/api/place/nearbysearch/json`, {
            params: {
                location,
                radius,
                type: 'parking',
                key
            }
        });
        res.json(response.data);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};
