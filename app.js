const express = require('express');
const body_parser = require('body-parser');
const userRouter = require('./routers/user.router');
const XChangedRouter = require('./routers/x-changed.router');

const app = express();
app.use(body_parser.json());


app.use('/',userRouter);
app.use('/',XChangedRouter);
 
module.exports = app;