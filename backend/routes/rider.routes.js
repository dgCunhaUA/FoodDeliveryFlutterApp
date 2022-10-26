const express = require("express");
const router = express.Router();

const auth = require("../middleware/auth");
const riderController = require("../controllers/rider.controller.js");

const multer = require('multer');
const upload = multer();

// Register
router.post("/register", upload.single("photo"), riderController.register);

// Login
router.post("/login", riderController.login);

module.exports = router;
