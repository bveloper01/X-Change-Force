const XChanged = require('../model/x-changed.currency.model');

class xChangedServices{

    static async createXchnaged(userID,amount1,from,amount2,to,date){
        const createXChanged = new XChanged({userID,amount1,from,amount2,to,date});
        return await createXChanged.save();

    }
    static async getxChanged(userID){
        const getXChangedata = await XChanged.find({userID})
        return getXChangedata;

    }
}
module.exports = xChangedServices;