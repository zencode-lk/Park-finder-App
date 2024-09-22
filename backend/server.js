require('dotenv').config();

const express = require('express');
const cors = require('cors');
const bodyParser = require('body-parser');
const connectDB = require('./config/db');
const userRoutes = require('./routes/userRoutes');
const placeRoutes = require('./routes/placeRoutes');
const errorHandler = require('./utils/errorHandler');
const vehicleRoutes = require('./routes/vehicleRoutes');

const app = express();
const port = 3000;

// Middleware
app.use(bodyParser.json());
app.use(cors());

// Connect to MongoDB
connectDB();

// Routes
app.use('/api/users', userRoutes);
app.use('/api/places', placeRoutes);
app.use('/api/vehicles', vehicleRoutes);

// Error handling middleware
app.use(errorHandler);

// Start the server
app.listen(port, () => 
  console.log(`Server running on port ${port}`)
);
