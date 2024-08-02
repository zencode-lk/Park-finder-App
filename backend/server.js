const express = require('express');
const mongoose = require('mongoose');
const bodyParser = require('body-parser');
const cors = require('cors');
const jwt = require('jsonwebtoken');


const app = express();
const port = 3001;
const secretKey = 'qwertyuiopasdfghjklmnbvcxztgv12as2As';
// Middleware
app.use(bodyParser.json());
app.use(cors());

// Connect to MongoDB
const mongoURI = 'mongodb+srv://vidundesu:ANmyfBkf2Fnlnngj@parkfinder.jdubhbw.mongodb.net/?retryWrites=true&w=majority&appName=parkFinder';

mongoose.connect(mongoURI, { useNewUrlParser: true, useUnifiedTopology: true })
  .then(() => console.log('MongoDB connected'))
  .catch(err => {
    console.log('MongoDB connection error:', err);
    process.exit(1); // Exit if connection fails
  });

// Define a simple User schema
const UserSchema = new mongoose.Schema({
  name: String,
  email: String,
  password: String,
});

const User = mongoose.model('User', UserSchema);

// Routes
app.get('/', (req, res) => res.send('API is running'));

// Create a new user
app.post('/api/users', async (req, res) => {
  try {
    const { name, email, password } = req.body;
    const newUser = new User({ name, email, password });
    await newUser.save();
    res.status(201).json(newUser);
  } catch (error) {
    res.status(400).json({ message: error.message });
  }
});

// Get all users
app.get('/api/users', async (req, res) => {
  try {
    const users = await User.find();
    res.status(200).json(users);
  } catch (error) {
    res.status(400).json({ message: error.message });
  }
});

// User login route
app.post('/api/login', async (req, res) => {
  try {
    const { email, password } = req.body;
    const user = await User.findOne({ email });

    if (!user) {
      return res.status(401).json({ message: 'User not found' });
    }

    if (user.password !== password) {
      return res.status(401).json({ message: 'Invalid password' });
    }

    // Generate JWT token
    const token = jwt.sign({ id: user._id }, secretKey, { expiresIn: '14d' });

    res.status(200).json({ message: 'Login successful', token });
  } catch (error) {
    res.status(400).json({ message: error.message });
  }
});

// Start the server
app.listen(port, () => console.log(`Server running on port ${port}`));
