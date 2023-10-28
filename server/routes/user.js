const express = require("express");
const {
  saveAddress,
  addToCart,
  postOrder,
  deleteFromCart,
  getOrders,
} = require("../controllers/userController");

const auth = require("../middlewares/auth");

const userRouter = express.Router();
//cart middlewares
userRouter.post("/api/add-to-cart", auth, addToCart);

userRouter.delete("/api/delete-from-cart", auth, deleteFromCart);

userRouter.post("/api/save-address", auth, saveAddress);

userRouter.post("/api/order", auth, postOrder);

userRouter.get("/api/order/getOrders", auth, getOrders);

module.exports = { userRouter };
