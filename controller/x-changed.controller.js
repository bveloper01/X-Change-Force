const xChangedServices = require('../services/x-changed.services');

exports.createXChanged = async(req, res ,next)=>{
    try{
        const {userID,amount1,from,amount2,to,date} = req.body;
        let XChanged = await xChangedServices.createXchnaged(userID,amount1,from,amount2,to,date);
        res.json({status:true, success:XChanged});

    }catch (error){
        throw error;
    }
}

exports.getxChangedData = async(req, res ,next)=>{
    try{
        const {userID} = req.body;
        let XChanged = await xChangedServices.getxChanged(userID);
        res.json({status:true, success: XChanged});

    }catch (error){
        throw error;
    }
}