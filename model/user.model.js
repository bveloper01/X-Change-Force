const mongoose = require('mongoose');
const db = require('../config/db');
const bcrypt = require("bcryptjs");


const { Schema } = mongoose;

const userScheme = new Schema({
    email:{
        type:String,
        lowercase:true,
        required:true,
        unique:true,
    },
    password:{
        type:String,
        required:true,

    }
});

userScheme.pre('save',async function(){
try{
    var user = this;
    const salt = await(bcrypt.genSalt(10));
    const hashpass = await(bcrypt.hash(user.password,salt));

    user.password = hashpass;
}catch(error){
    throw error ;
}
});

userScheme.methods.comparePassword = async function(userPassword) {
    try{
        const isMatch = await bcrypt.compare(userPassword,this.password);
        return isMatch;
    }catch (error){
        throw error ;
    }
}

const userModel = db.model('user', userScheme);
module.exports = userModel;