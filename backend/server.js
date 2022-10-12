require('dotenv').config()
require("./configs/database").connect();

const express = require("express");
const app = express();
const port = 3000;

app.use(express.json());

app.use("/api/client", require("./routes/client.routes"));

app.listen(port, () => {
	console.log(`Example app listening on port ${port}`);
});

