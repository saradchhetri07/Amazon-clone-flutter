const express = require("express");
const mongoose = require("mongoose");
require("dotenv").config();

const { authRouter } = require("./routes/auth");
const { adminRouter } = require("./routes/admin");
const { productRouter } = require("./routes/product");
const { searchRouter } = require("./routes/search");
const { userRouter } = require("./routes/user");
//INIT
const app = express();
const PORT = process.env.PORT || 3001;
//middleware
app.use(express.json());
app.use(authRouter);
app.use("/admin", adminRouter);
app.use(productRouter);
app.use(searchRouter);
app.use(userRouter);

const DB = process.env.URI;

mongoose
  .connect(DB)
  .then(() => {
    console.log("mongoose connected");
  })
  .catch((error) => {
    console.log(error);
  });

app.listen(PORT, () => {
  console.log(`Listening on port ${PORT}`);
});
