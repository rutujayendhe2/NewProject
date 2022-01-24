module.exports=(app)=>{

    const express=require('express');
    const ROUTER=express.Router();
    const CarController=require('./car-controller');
    ROUTER.get('/cars',CarController.findAll);
    ROUTER.get('/cars/:id',CarController.findByPk);
    ROUTER.post('/cars/add',CarController.createCar);
    ROUTER.put('/cars/update/:id',CarController.updateCar);
    ROUTER.delete('/cars/delete/:id',CarController.delete);

    app.use('/app',ROUTER);
}