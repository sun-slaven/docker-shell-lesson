var express = require('express');
var redis = require('redis');
var app = express();
app.set('view engine', 'ejs');
var client = redis.createClient({
    host: process.env.REDIS_HOST,
    port: process.env.REDIS_PORT
});

app.get('/', function (req, res) {
  client.incr('hits', function(err, replies) {
    res.render('index', { num: replies , hostname: process.env.HOSTNAME});
  })
});

app.listen(3000, function () {
  console.log('Example app listening on port 3000!')
});
