/*
 * This is the localhost backend code for our app, just for getting 
 * contact lists from a local json file (contacts.json)
 * To run , go to 'backend' folder and run 'node app.js' in terminal
 
 ? for production, we put backend code in a seprate project and deploy it to the web
 */

const express = require('express');
const app = express();
const PORT = process.env.PORT || 5000;
const contacts = require('./contacts.json');

// app.get('/', _ => '<h1>Flutter Practise</h1>')
app.get('/contacts', (req, res) => {
    const { q } = req.query;

    console.log(`Backend hit with ${q}`);

    let r = contacts;
    if (q) {
        r = contacts.filter(({ name }) => name.toLowerCase().match(q.toLowerCase()))
    }
    return res.json(r)
});


app.listen(PORT, () => { console.log(`Server started at port ${PORT}`) });
