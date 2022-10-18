require("dotenv").config();
require("./configs/database").connect();

const express = require("express");
const app = express();
const port = 3000;

const multer = require('multer');
const upload = multer();

app.use(express.json());

app.use("/api/client", require("./routes/client.routes"));
app.use("/api/restaurant", require("./routes/restaurant.routes"));

app.listen(port, () => {
	console.log(`Example app listening on port ${port}`);
});

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

module.exports = { sequelize, upload };