const lambda = require("./index");
var express = require('express');

var app = express();

// app.get('/_healthz', function (req, res) {
//   res.send('1');
// });


app.get('/thumbnail/:urlInput', function (req, res) {
    console.log(req.url)
    console.log(req.query)
    
    req.url=req.url.replace("/thumbnail/","")

    lambda.handler(
        {queryStringParameters: req.query}, 
        null,
        async function (something, callback){
            console.log("callback: ", callback)
            res.status(callback.statusCode).header(callback.headers).send(callback.body)
        }
    )
  })


app.listen(5000, function () {
console.log('listening on :5000');
})