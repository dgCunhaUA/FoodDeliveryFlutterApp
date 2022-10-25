const Order = require("../models/order.model");

exports.create = async (req, res) => {
	try {
		// Get order input
		const {
			restaurant_name,
			restaurant_address,
			client_name,
			client_address,
			rider,
		} = req.body;

		const photo = req.file;

		// Validate order input
		if (
			!(
				restaurant_name &&
				restaurant_address &&
				client_name &&
				client_address &&
				rider
			)
		) {
			res.status(400).send("All input is required");
		}

		// check if order already exist
		// Validate if order exist in our database
		/* const oldRestaurant = await Order.findOne({ where: { name: name } });
		if (oldRestaurant) {
			return res.status(409).send("Order Already Exist.");
		} */

		// Create order in our database
		const order = await Order.create({
			restaurant_name,
			restaurant_address,
			client_name,
			client_address,
			rider,
		});

		// return new order
		res.status(201).json(order);
	} catch (err) {
		console.log(err);
	}
};
