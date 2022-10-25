const express = require("express");
const router = express.Router();

const auth = require("../middleware/auth");
const riderController = require("../controllers/rider.controller.js");

// Register
router.post("/register", riderController.register);

// Login
router.post("/login", riderController.login);

module.exports = router;
