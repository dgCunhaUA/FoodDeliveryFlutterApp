const express = require("express");
const router = express.Router();

const auth = require("../middleware/auth");
const orderController = require("../controllers/order.controller.js");

router.get("/", auth, (req, res) => {
	res.send("hello world");
});

// Register
router.post("/create", orderController.create);

// Login
//router.post("/login", clientController.login);

module.exports = router;
