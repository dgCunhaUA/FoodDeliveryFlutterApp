const { Sequelize, DataTypes } = require("sequelize");

const sequelize = new Sequelize(
    'proj1',
    'root',
    'root',
     {
       host: 'localhost',
       dialect: 'mysql'
     }
   );

const client = sequelize.define("client", {
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
		unique: true
	},
	password: {
		type: DataTypes.STRING,
		allowNull: false,
		unique: true
	},
	token: {
		type: DataTypes.STRING,
	}
});

module.exports = sequelize.model("client", client)