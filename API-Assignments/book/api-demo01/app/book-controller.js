const db = require('../db/models');
	const Book = db.Book;
	//select * from people;
	exports.findAll = (req, resp) => {
		Book.findAll()
			.then((data) => { resp.json(data); })
			.catch((err) => {
				resp.status(500).send({
					message: err.message || " Something went"
				})
			})
	
	}
	exports.findByPk = (req, resp) => {
		const id=req.params.id;
	
		Book.findByPk(id)
			.then(data=>{resp.send(data)})
			.catch((err) => {
				resp.status(500).send({
					message: err.message || ` Some error retriving Book data with id ${id}`
				})
			})
	}
	exports.create = (req, resp) => {
		if(!req.body.firstName){
			res.status(400).send({
				message: "Content can not be empty!"
			});
			return;
		}
		const newBook={
			firstName: req.body.firstName,
			lastName: req.body.lastName,
			createdAt:new Date(),
			updatedAt:new Date()
		}
		Book.create(newBook)
			.then(data=>{resp.send(data);})
			.catch((err) => {
				resp.status(500).send({
					message: err.message || " Some error Creating new Book data"
				})
			})
	}
	//update people set firstName=?, lastName=? where id=?
	exports.update = (req, resp) => {
		const id = req.params.id;
	
		Book.update(req.body, { where: { id: id } })
			.then(num => {
				if (num == 1) {
				resp.send({
					message: `Book with id ${id} updated successfully.`
				});
				} else {
				resp.send({
					message: `Cannot update Book with id=${id}. Maybe Book was not found or req.body is empty!`
				});
				}
			})
			.catch((err) => {
				resp.status(500).send({
					message: err.message || " Some error retriving Book data"
				})
			})
	}
	//delete from Book where id=?
	exports.delete = (req, resp) => {
		const id = req.params.id;
		Book.destroy({ where: { id: id } })
			.then(num => {
				if (num == 1) {
					resp.send({ message: `Book with id=${id} deleted successfully!` });
				} else {
					resp.send({ message: `Cannot delete Book with id=${id}. Maybe Book was not found!` });
				}
			})
			.catch((err) => {
				resp.status(500).send({
					message: err.message || " Could not delete Book with id=" + id
				})
			})
	}
	