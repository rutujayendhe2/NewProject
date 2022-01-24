module.exports=(app)=>{

    const express=require('express');
    const ROUTER=express.Router();
    const AccountController=require('./account-controller');
    ROUTER.get('/accounts',AccountController.findAll);
    ROUTER.get('/accounts/:id',AccountController.findByPk);
    ROUTER.post('/accounts/add',AccountController.create);
    ROUTER.put('/accounts/update/:id',AccountController.update);
    ROUTER.delete('/accounts/delete/:id',AccountController.delete);

    app.use('/app',ROUTER);
}