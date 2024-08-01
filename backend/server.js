const express = require('express');
const mongoose = require('mongoose');
const bodyParser = require('body-parser');
const cors = require('cors');

const app = express();
const port = 3000;

// Middleware
app.use(bodyParser.json());
app.use(cors());

// Connect to MongoDB
const mongoURI = 'mongodb+srv://vidundesu:ANmyfBkf2Fnlnngj@parkfinder.jdubhbw.mongodb.net/?retryWrites=true&w=majority&appName=parkFinder';
mongoose.connect(mongoURI, { useNewUrlParser: true, useUnifiedTopology: true })
  .then(() => console.log('MongoDB connected'))
  .catch(err => console.log(err));

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

// Start the server
app.listen(port, () => console.log(`Server running on port ${port}`));
