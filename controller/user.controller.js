const UserService = require('../services/user.services')

exports.register = async(req, res ,next)=>{
    try{
        const {email,password} = req.body;
        const successRes = await UserService.registerUser(email,password);
        res.json({status:true, success:"User Registeration Successful"});

    }catch (error){
        throw error
    }
}
exports.login = async(req, res ,next)=>{
    try{
        const {email,password} = req.body;
       const user = await UserService.checkuser(email);

       if(!user){
        throw new Error("User don\'t exist");
       }


       const isMatch = await user.comparePassword(password);
       if (isMatch == false){
        throw new Error("Invalid Password");
       }

       let tokenData = {_id:user._id,email:user.email};
       const token = await UserService.generateToken(tokenData,"secretKey","1h")
       res.status(200).json({status:true,token:token})



    }catch (error){
        throw error;
    }
}