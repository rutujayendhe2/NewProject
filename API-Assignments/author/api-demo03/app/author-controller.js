const db = require('../db/models');
	const Author = db.Author;
	//select * from Author;
	exports.findAll = (req, resp) => {
		Author.findAll()
			.then((data) => { resp.json(data); })
			.catch((err) => {
				resp.status(500).send({
					message: err.message || " Something went wrong!"
				})
			})
	
	}
	exports.findByPk = (req, resp) => {
		const id=req.params.id;
	
		Author.findByPk(id)
			.then(data=>{resp.send(data)})
			.catch((err) => {
				resp.status(500).send({
					message: err.message || ` Some error retriving Car data with id ${id}`
				})
			})
	}
	//insert into Author 

	exports.create = (req, resp) => {
		if(!req.body.authorName){
			res.status(400).send({
				message: "Content can not be empty!"
			});
			return;
		}
		const newAuthor={
			authorName: req.body.authorName,
			bookName: req.body.bookName,
			createdAt:new Date(),
			updatedAt:new Date()
		}
		Author.create(newCar)
			.then(data=>{resp.send(data);})
			.catch((err) => {
				resp.status(500).send({
					message: err.message || " Some error Creating new Person data"
				})
			})
	}
	//update Author 
	exports.update = (req, resp) => {
		const id = req.params.id;
	
		Author.update(req.body, { where: { id: id } })
			.then(num => {
				if (num == 1) {
				resp.send({
					message: `Author with id ${id} updated successfully.`
				});
				} else {
				resp.send({
					message: `Cannot update Author with id=${id}. Maybe Author was not found or req.body is empty!`
				});
				}
			})
			.catch((err) => {
				resp.status(500).send({
					message: err.message || " Some error retriving Author data"
				})
			})
	}
	//delete from Author where id=?
	exports.delete = (req, resp) => {
		const id = req.params.id;
		Author.destroy({ where: { id: id } })
			.then(num => {
				if (num == 1) {
					resp.send({ message: `Author with id=${id} deleted successfully!` });
				} else {
					resp.send({ message: `Cannot delete Author with id=${id}. Maybe Author was not found!` });
				}
			})
			.catch((err) => {
				resp.status(500).send({
					message: err.message || " Could not delete Author with id=" + id
				})
			})
	}
	