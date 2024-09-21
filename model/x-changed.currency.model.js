const mongoose = require('mongoose');
const db = require('../config/db');
const userModel = require("./user.model")


const { Schema } = mongoose;

const XChangedCurrency = new Schema({
    userID:{
        type:Schema.Types.ObjectId,
        ref:userModel.modelName,
        required:true,
    },
    amount1:{
        type:String,
        required:true,
    },
    from:{
        type:String,
        required:true,

    },
    amount2:{
        type:String,
        required:true,

    },
    to:{
        type:String,
        required:true,

    },
    date:{
        type:String,
        required:true,

    }

});



const XChanged = db.model('X-change', XChangedCurrency);
module.exports = XChanged;