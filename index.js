const express = require('express');
const pgp = require('pg-promise')();
const bodyParser = require('body-parser');

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(bodyParser.json());

// Database connection
const db = pgp('postgres://username:password@localhost:5432/database_name');  //Change this to postgre our one

// Sample route to get all habits
app.get('/habits', async (req, res) => {
    try {
        const habits = await db.any('SELECT * FROM habits');
        res.json(habits);
    } catch (error) {
        console.error('Error fetching habits:', error);
        res.status(500).json({ error: 'Internal server error' });
    }
});

// Sample route to add a new habit
app.post('/habits', async (req, res) => {
    const { name, description } = req.body;
    try {
        const newHabit = await db.one('INSERT INTO habits(name, description) VALUES($1, $2) RETURNING *', [name, description]);
        res.status(201).json(newHabit);
    } catch (error) {
        console.error('Error adding habit:', error);
        res.status(500).json({ error: 'Internal server error' });
    }
});

// Start the server
app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});
