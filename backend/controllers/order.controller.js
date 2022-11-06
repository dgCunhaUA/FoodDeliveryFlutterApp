const { Sequelize, DataTypes } = require("sequelize");

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

		const order_status = "Waiting";
		// Create order in our database
		const order = await Order.create({
			restaurant_name,
			restaurant_address,
			client_id,
			client_name,
			client_address,
			order_status,
		});

		// return new order
		res.status(201).json(order);
	} catch (err) {
		console.log(err);
	}
};

exports.accept = async (req, res) => {
	try {
		const { order_id, rider_name, rider_lat, rider_lng, order_status } =
			req.body;

		// Validate order input
		if (
			!(order_id && rider_name && rider_lat && rider_lng && order_status)
		) {
			res.status(400).send("All input is required");
		}

		// Validate if order exist in our database
		const order = await Order.findOne({
			where: {
				id: order_id,
			},
		});

		if (order == null) {
			res.status(400).send("Order doesnt exist");
		}

		if (order.order_status != "Delivering") {
			// Create order in our database
			order.rider_name = rider_name;
			order.rider_lat = rider_lat;
			order.rider_lng = rider_lng;
			order.order_status = order_status;
			const updatedOrder = await order.save();

			// return new order
			res.status(201).json(updatedOrder);
		} else {
			res.status(400).send("Order already being delivered");
		}
	} catch (err) {
		console.log(err);
	}
};

exports.getClientActiveOrders = async (req, res) => {
	const clientId = req.params.id;

	if (!clientId) return res.status(400).send("Client id is required");

	const orders = await Order.findAll({
		where: Sequelize.and(
			{ client_id: clientId },
			Sequelize.or(
				{ order_status: "Delivering" },
				{ order_status: "Waiting" }
			)
		),
	});

	return res.status(200).json(orders);
};
