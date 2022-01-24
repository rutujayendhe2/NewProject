module.exports=(app)=>{

    const express=require('express');
    const ROUTER=express.Router();
    const HeroController=require('./hero-controller');
    ROUTER.get('/heros',HeroController.findAll);
    ROUTER.get('/heros/:id',HeroController.findByPk);
    ROUTER.post('/heros/add',HeroController.create);
    ROUTER.put('/heros/update/:id',HeroController.update);
    ROUTER.delete('/heros/delete/:id',HeroController.delete);

    app.use('/app',ROUTER);
}