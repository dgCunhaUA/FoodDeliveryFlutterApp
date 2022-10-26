
const Client = require("../models/client.model");

const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");
const fs = require('fs')

exports.register = async (req, res) => {
	try {
		// Get client input
		const { name, address, email, password } = req.body;

		const photo = req.file;

		// Validate client input
		if (!(email && password && name && address)) {
			res.status(400).send("All input is required");
		}

		// check if client already exist
		// Validate if client exist in our database
		const oldClient = await Client.findOne({ where: { email: email } });
		if (oldClient) {
			return res.status(409).send("User Already Exist. Please Login");
		}

		//Encrypt user password
		encryptedPassword = await bcrypt.hash(password, 10);

		// Create user in our database
		const client = await Client.create({
			name,
			//birthdate: new Date(Date.UTC(2016, 0, 1)),
			address,
			email: email.toLowerCase(), // sanitize: convert email to lowercase
			password: encryptedPassword,
			photo: photo ?? null,
		});

		// Create token
		const token = jwt.sign(
			{ user_id: client._id, email },
			process.env.TOKEN_KEY
		);
		// save client token
		client.token = token;

		// return new client
		res.status(201).json(client);
	} catch (err) {
		console.log(err);
	}
	// Our register logic ends here
};

exports.login = async (req, res) => {
	// Our login logic starts here
	try {
		// Get client input
		const { email, password } = req.body;

		// Validate client input
		if (!(email && password)) {
			res.status(400).send("All input is required");
		}
		// Validate if client exist in our database
		const client = await Client.findOne({
			where: {
				email: email,
			},
		});

		if (client && (await bcrypt.compare(password, client.password))) {
			// Create token
			const token = jwt.sign(
				{ user_id: client._id, email },
				process.env.TOKEN_KEY,
				{
					expiresIn: "2h",
				}
			);

			// save user token
			client.token = token;

			// client
			res.status(200).json(client);
		} else {
			res.status(400).send("Invalid Credentials");
		}
	} catch (err) {
		console.log(err);
	}
	// Our register logic ends here
};


exports.upload = async (req, res) => {
	try {
		console.log(req.file);
		const id = req.body["id"];

		const client = await Client.findOne({
			where: {
				id: id,
			},
		});

		console.log(req.file)
		//fs.writeFileSync(req.file);

		console.log("....");

		console.log(req.file.filename)

		client.photo = req.file.filename;
		client.save();

		console.log(client)

		res.send("file uploaded successfully.");
	} catch (error) {
		console.log(error)
		res.status(400).send("Error while uploading file. Try again later.");
	}
};

exports.download = async (req, res) => {
	console.log(req.params)
	try {
		console.log(req.body)
		console.log(req.params)
		const id = req.params.id;
		const client = await Client.findOne({
			where: {
				id: id,
			},
		});

		console.log(client.photo)

		//const file = await File.findById(req.params.id);
		res.set({
			"Content-Type": client.photo,
		});
		//res.sendFile(path.join(__dirname, "..", file.file_path));
		//res.sendFile(client.photo)
		res.send(client.photo)
	} catch (error) {
		console.log(error)
		res.status(400).send("Error while downloading file. Try again later.");
	}
};


exports.getImg = async (req, res) => {
	const filename = req.params["filename"]
	res.sendFile("/Users/cunha/Desktop/CM/flutter_project/backend/uploads/"+filename)
}

/* sequelize
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
}); */
