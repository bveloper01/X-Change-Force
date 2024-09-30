const db = require('./config/db')
const app  =require('./app');
const UserModel = require('./model/user.model');
const XChanged= require('./model/x-changed.currency.model');

const port = process.env.PORT || 3000;

app.get('/',(req,res)=>{
    res.send("deadpool and wolverine is best movie ever")
})
app.listen(port, () => {
    console.log(`Server is running on port ${port}`);
  });