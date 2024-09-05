const express = require('express');
const app = express();
const port = 3000;
const mysql = require('mysql');

const connection = mysql.createConnection({
    host: 'db',
    user: 'root',
    password: 'example',
    database: 'test'
})

connection.connect((err) => {
    if (err) throw err;
    console.log('Connected to MySQL');
});

app.get('/', (req, res) => {
    res.send('Hello, Docker!');
});

// Route to test MySQL connection
app.get('/db-test', (req, res) => {
    connection.query('SELECT 1 + 1 AS solution', (error, results) => {
        if (error) throw error;
        res.send(`Database test: The solution is ${results[0].solution}`);
    });
});

app.listen(port, () => {
    console.log(`App running at http://localhost:${port}`);
});
