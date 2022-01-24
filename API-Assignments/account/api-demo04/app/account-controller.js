const db = require('../db/models');
	const Account = db.Account;
	//select * from Account;
	exports.findAll = (req, resp) => {
		Account.findAll()
			.then((data) => { resp.json(data); })
			.catch((err) => {
				resp.status(500).send({
					message: err.message || " Something went wrong!"
				})
			})
	
	}
	exports.findByPk = (req, resp) => {
		const id=req.params.id;
	
		Account.findByPk(id)
			.then(data=>{resp.send(data)})
			.catch((err) => {
				resp.status(500).send({
					message: err.message || ` Some error retriving Account data with id ${id}`
				})
			})
	}
	//insert into Account 

	exports.create = (req, resp) => {
		if(!req.body.accno){
			res.status(400).send({
				message: "Content can not be empty!"
			});
			return;
		}
		const newAccount={
			accno: req.body.accno,
			accnamr: req.body.accnamr,
            balance: req.body.balance,
			createdAt:new Date(),
			updatedAt:new Date()
		}
		Account.create(newAccount)
			.then(data=>{resp.send(data);})
			.catch((err) => {
				resp.status(500).send({
					message: err.message || " Some error Creating new Account data"
				})
			})
	}
	//update Account 
	exports.update = (req, resp) => {
		const id = req.params.id;
	
		Account.update(req.body, { where: { id: id } })
			.then(num => {
				if (num == 1) {
				resp.send({
					message: `Account with id ${id} updated successfully.`
				});
				} else {
				resp.send({
					message: `Cannot update Account with id=${id}. Maybe Account was not found or req.body is empty!`
				});
				}
			})
			.catch((err) => {
				resp.status(500).send({
					message: err.message || " Some error retriving Account data"
				})
			})
	}
	//delete from Account where id=?
	exports.delete = (req, resp) => {
		const id = req.params.id;
		Account.destroy({ where: { id: id } })
			.then(num => {
				if (num == 1) {
					resp.send({ message: `Account with id=${id} deleted successfully!` });
				} else {
					resp.send({ message: `Cannot delete Account with id=${id}. Maybe Account was not found!` });
				}
			})
			.catch((err) => {
				resp.status(500).send({
					message: err.message || " Could not delete Account with id=" + id
				})
			})
	}
	