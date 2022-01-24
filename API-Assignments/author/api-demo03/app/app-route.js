module.exports=(app)=>{

    const express=require('express');
    const ROUTER=express.Router();
    const AuthorController=require('./author-controller');
    ROUTER.get('/authors',AuthorController.findAll);
    ROUTER.get('/authors/:id',AuthorController.findByPk);
    ROUTER.post('/authors/add',AuthorController.create);
    ROUTER.put('/authors/update/:id',AuthorController.update);
    ROUTER.delete('/authors/delete/:id',AuthorController.delete);

    app.use('/app',ROUTER);
}