// Import required modules
const express = require('express');

// Create an instance of Express application
const app = express();
const port = 3000;

// Define a simple route
app.get('/', (req, res) => {
  res.send('Hello World!');
});

// Define another route
app.get('/api/habits', (req, res) => {
  // Assume habits data is fetched from SQLite database
  const habits = [
    { id: 1, name: 'Exercise', frequency: 'Daily' },
    { id: 2, name: 'Reading', frequency: 'Weekly' }
  ];
  res.json(habits);
});

// Start the server
app.listen(port, () => {
  console.log(`Server is running on http://localhost:${port}`);
});
