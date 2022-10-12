const { Sequelize, DataTypes } = require("sequelize");

const sequelize = new Sequelize("proj1", "root", "root", {
	host: "localhost",
	dialect: "mysql",
});

sequelize
	.authenticate()
	.then(() => {
		console.log("Connection has been established successfully.");
	})
	.catch((error) => {
		console.error("Unable to connect to the database: ", error);
	});

const Client = sequelize.define("client", {
	name: {
		type: DataTypes.STRING,
		allowNull: false,
	},
	birthdate: {
		type: DataTypes.DATE,
		allowNull: false,
	},
	address: {
		type: DataTypes.STRING,
		allowNull: false,
	},
});

sequelize
	.sync()
	.then(() => {
		console.log("Client table created successfully!");

		Client.create({
			name: "cunha",
			birthdate: new Date(Date.UTC(2016, 0, 1)),
			address: "Tv xpto",
		})
			.then((res) => {
				console.log(res);
			})
			.catch((error) => {
				console.error("Failed to create a new record : ", error);
			});
	})
	.catch((error) => {
		console.error("Unable to create table : ", error);
	});


sequelize.sync().then(() => {

    Client.findAll().then(res => {
        console.log(res)
    }).catch((error) => {
        console.error('Failed to retrieve data : ', error);
    });

}).catch((error) => {
    console.error('Unable to create table : ', error);
});