const Order = require("../models/order.model");

exports.create = async (req, res) => {
	try {
		// Get order input
		const {
			restaurant_name,
			restaurant_address,
			client_id,
			client_name,
			client_address,
		} = req.body;

		console.log(req.body);

		// Validate order input
		if (
			!(
				restaurant_name &&
				restaurant_address &&
				client_id &&
				client_name &&
				client_address
			)
		) {
			res.status(400).send("All input is required");
		}

		// Create order in our database
		const order = await Order.create({
			restaurant_name,
			restaurant_address,
			client_id,
			client_name,
			client_address,
		});

		// return new order
		res.status(201).json(order);
	} catch (err) {
		console.log(err);
	}
};

exports.accept = async (req, res) => {
	try {
		const { order_id, rider_name, rider_lat, rider_lng} = req.body;
		
		// Validate order input
		if (
			!(
				order_id &&
				rider_name &&
				rider_lat &&
				rider_lng
			)
		) {
			res.status(400).send("All input is required");
		}

		// Validate if order exist in our database
		const order = await Order.findOne({
			where: {
				id: order_id,
			},
		});

		if(order == null) {
			res.status(400).send("Order doesnt exist");
		}

		// Create order in our database
		order.rider_name = rider_name;
		order.rider_lat = rider_lat;
		order.rider_lng = rider_lng;
		const updatedOrder = await order.save();

		// return new order
		res.status(201).json(updatedOrder);
	} catch (err) {
		console.log(err);
	}
};
