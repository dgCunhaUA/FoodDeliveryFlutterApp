const Rider = require("../models/rider.model");

const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");

exports.register = async (req, res) => {
	try {
		// Get rider input
		const { name, address, email, password, vehicle } =
			req.body;
			
		const photo = req.file;

		// Validate rider input
		if (
			!(
				email &&
				password &&
				name &&
				address &&
                vehicle
			)
		) {
			res.status(400).send("All input is required");
		}

		// check if rider already exist
		// Validate if rider exist in our database
		const oldClient = await Rider.findOne({ where: { email: email } });
		if (oldClient) {
			return res.status(409).send("Rider Already Exist.");
		}

		//Encrypt user password
		encryptedPassword = await bcrypt.hash(password, 10);

		// Create user in our database
		const rider = await Rider.create({
			name,
			//birthdate: new Date(Date.UTC(2016, 0, 1)),
			address,
			email: email.toLowerCase(), // sanitize: convert email to lowercase
			password: encryptedPassword,
			vehicle: vehicle,
			photo: photo ?? null,
		});

		// Create token
		const token = jwt.sign(
			{ user_id: rider._id, email },
			process.env.TOKEN_KEY,
		);
		// save rider token
		rider.token = token;

		// return new rider
		res.status(201).json(rider);
	} catch (err) {
		console.log(err);
	}
	// Our register logic ends here
};

exports.login = async (req, res) => {
	// Our login logic starts here
	try {
		// Get rider input
		const { email, password } = req.body;

		// Validate rider input
		if (!(email && password)) {
			res.status(400).send("All input is required");
		}
		// Validate if rider exist in our database
		const rider = await Rider.findOne({
			where: {
				email: email,
			},
		});

		if (rider && (await bcrypt.compare(password, rider.password))) {
			// Create token
			const token = jwt.sign(
				{ user_id: rider._id, email },
				process.env.TOKEN_KEY,
			);

			// save user token
			rider.token = token;

			// rider
			res.status(200).json(rider);
		} else {
			res.status(400).send("Invalid Credentials");
		}
	} catch (err) {
		console.log(err);
	}
	// Our register logic ends here
};