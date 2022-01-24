const db = require('../db/models');
	const Car = db.Car;
	//select * from car;
	exports.findAll = (req, resp) => {
		Car.findAll()
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
	exports.createCar = (req, resp) => {
		if(!req.body.carName){
			res.status(400).send({
				message: "Content can not be empty!"
			});
			return;
		}
		const newCar={
			carName: req.body.carName,
			brandName: req.body.brandName,
			createdAt:new Date(),
			updatedAt:new Date()
		}
		Car.create(newCar)
			.then(data=>{resp.send(data);})
			.catch((err) => {
				resp.status(500).send({
					message: err.message || " Some error Creating new Person data"
				})
			})
	}
	//update people set firstName=?, lastName=? where id=?
	exports.updateCar = (req, resp) => {
		const id = req.params.id;
	
		Car.update(req.body, { where: { id: id } })
			.then(num => {
				if (num == 1) {
				resp.send({
					message: `Car with id ${id} updated successfully.`
				});
				} else {
				resp.send({
					message: `Cannot update Car with id=${id}. Maybe Car was not found or req.body is empty!`
				});
				}
			})
			.catch((err) => {
				resp.status(500).send({
					message: err.message || " Some error retriving Car data"
				})
			})
	}
	//delete from car where id=?
	exports.delete = (req, resp) => {
		const id = req.params.id;
		Car.destroy({ where: { id: id } })
			.then(num => {
				if (num == 1) {
					resp.send({ message: `Car with id=${id} deleted successfully!` });
				} else {
					resp.send({ message: `Cannot delete Car with id=${id}. Maybe Car was not found!` });
				}
			})
			.catch((err) => {
				resp.status(500).send({
					message: err.message || " Could not delete Car with id=" + id
				})
			})
	}
	