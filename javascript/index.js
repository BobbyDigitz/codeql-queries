const express = require('express')
const bodyParser = require('body-parser');

const app = express()
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

app.get('/', (req, res) => {
  let name = req.query.name;

  res.send(`Hello ${name}!`)
})

app.listen(5000, () => {
  console.log(`Example app listening on port ${port}`)
})