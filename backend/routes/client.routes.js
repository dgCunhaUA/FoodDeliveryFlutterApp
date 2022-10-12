const express = require("express");
const router = express.Router();

const auth = require("../middleware/auth");
const clientController = require("../controllers/client.controller.js");

router.get("/", auth, (req, res) => {
	res.send("hello world");
});

// Register
router.post("/register", clientController.register);

// Login
router.post("/login", clientController.login);

module.exports = router;
