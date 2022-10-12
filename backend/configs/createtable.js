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

/* const client = sequelize.define("client", {
	first_name: {
		type: DataTypes.STRING,
		allowNull: false,
	},
	last_name: {
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
	email: {
		type: DataTypes.STRING,
		allowNull: false,
		unique: true,
	},
	password: {
		type: DataTypes.STRING,
		allowNull: false,
		unique: true,
	},
	token: {
		type: DataTypes.STRING,
	},
}); */

const restaurant = sequelize.define("restaurant", {
	name: {
		type: DataTypes.STRING,
		allowNull: false,
	},
	address: {
		type: DataTypes.STRING,
		allowNull: false,
	},
    photo: {
        type: DataTypes.BLOB
    },
	description: {
		type: DataTypes.STRING,
	},
});

sequelize
	.sync()
	.then(() => {
		console.log("Client table created successfully!");
	})
	.catch((error) => {
		console.error("Unable to create table : ", error);
	});
