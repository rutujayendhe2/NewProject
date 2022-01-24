const db = require('../db/models');
	const Hero = db.Hero;
	//select * from Hero;
	exports.findAll = (req, resp) => {
		Hero.findAll()
			.then((data) => { resp.json(data); })
			.catch((err) => {
				resp.status(500).send({
					message: err.message || " Something went wrong!"
				})
			})
	
	}
	exports.findByPk = (req, resp) => {
		const id=req.params.id;
	
		Car.findByPk(id)
			.then(data=>{resp.send(data)})
			.catch((err) => {
				resp.status(500).send({
					message: err.message || ` Some error retriving Car data with id ${id}`
				})
			})
	}
	//insert into car (carName,brandName,createdAt,updatedAt)
	//values(?,?,?,?)
	exports.create = (req, resp) => {
		if(!req.body.heroName){
			res.status(400).send({
				message: "Content can not be empty!"
			});
			return;
		}
		const newhero={
			heroName: req.body.heroName,
			filmName: req.body.filmName,
			createdAt:new Date(),
			updatedAt:new Date()
		}
		Hero.create(newhero)
			.then(data=>{resp.send(data);})
			.catch((err) => {
				resp.status(500).send({
					message: err.message || " Some error Creating new Person data"
				})
			})
	}
	//update people set firstName=?, lastName=? where id=?
	exports.update = (req, resp) => {
		const id = req.params.id;
	
		Hero.update(req.body, { where: { id: id } })
			.then(num => {
				if (num == 1) {
				resp.send({
					message: `Hero with id ${id} updated successfully.`
				});
				} else {
				resp.send({
					message: `Cannot update Hero with id=${id}. Maybe Hero was not found or req.body is empty!`
				});
				}
			})
			.catch((err) => {
				resp.status(500).send({
					message: err.message || " Some error retriving Hero data"
				})
			})
	}
	//delete from Hero where id=?
	exports.delete = (req, resp) => {
		const id = req.params.id;
		Hero.destroy({ where: { id: id } })
			.then(num => {
				if (num == 1) {
					resp.send({ message: `Hero with id=${id} deleted successfully!` });
				} else {
					resp.send({ message: `Cannot delete Hero with id=${id}. Maybe Hero was not found!` });
				}
			})
			.catch((err) => {
				resp.status(500).send({
					message: err.message || " Could not delete Hero with id=" + id
				})
			})
	}
	