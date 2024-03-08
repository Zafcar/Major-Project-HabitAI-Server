const sqlite3 = require('better-sqlite3');

const db = new sqlite3('./habits.db', { verbose: console.log });

// Define your tables (habits, completions, etc.) using SQL syntax
db.exec(`
  CREATE TABLE IF NOT EXISTS habits (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT NOT NULL,
    description TEXT
  );
`);

// Additional table creation for completions etc.

module.exports = db;
