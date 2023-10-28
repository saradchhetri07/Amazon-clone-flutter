const express = require("express");
const {
  signUp,
  checkToken,
  signIn,
  logInUser,
} = require("../controllers/authController");
const authRouter = express.Router();
const auth = require("../middlewares/auth");

//register user
authRouter.post("/api/signUp", signUp);

//SignIn
authRouter.post("/api/signIn", signIn);

//verifying token
authRouter.post("/isValidToken", checkToken);

//middleware
authRouter.get("/", auth, logInUser);

module.exports = { authRouter };
