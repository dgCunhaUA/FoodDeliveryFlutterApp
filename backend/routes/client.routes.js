const express = require("express");
const router = express.Router();
const path = require("path");

const auth = require("../middleware/auth");
const clientController = require("../controllers/client.controller.js");

const multer = require("multer");
//const upload = multer({ dest: "uploads/" });
var storage = multer.diskStorage({
	destination: function (req, file, cb) {
	  console.log(req.body.internalUserID) // YAY, IT'S POPULATED
	  cb(null, 'uploads/')
	},                    
	filename: function (req, file, cb) {
	  cb(null, req.body["filename"])
	}                     
  }); 
const upload = multer({storage: storage})

router.get("/", auth, (req, res) => {
	res.send("hello world");
});

// Register
router.post("/register", upload.single("photo"), clientController.register);

// Login
router.post("/login", clientController.login);

router.post("/upload", upload.single("photo"), clientController.upload);

//router.get("/photo/:filename", clientController.getImg);

router.get("/photo/:id", clientController.download);

module.exports = router;
