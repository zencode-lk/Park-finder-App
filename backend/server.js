require('dotenv').config();
const express = require('express');
const cors = require('cors');
const bodyParser = require('body-parser');
const connectDB = require('./config/db');
const userRoutes = require('./routes/userRoutes');
const landRoute = require('./routes/landRoute');
const placeRoutes = require('./routes/placeRoutes');
const errorHandler = require('./utils/errorHandler');
const vehicleRoutes = require('./routes/vehicleRoutes');
const scheduleRoute = require('./routes/scheduleRoute');

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
app.use('/api/land', landRoute);
app.use('/api/schedule', scheduleRoute)
// Error handling middleware
app.use(errorHandler);

// Start the server
app.listen(port, () => 
  console.log(`Server running on port ${port}`)
);
