const express = require("express");
const {
  addProduct,
  getProducts,
  deleteProduct,
  fetchAllOrders,
  changeStatus,
  getAnalytics,
} = require("../controllers/adminController");
const admin = require("../middlewares/admin");
const adminRouter = express.Router();

//admin middlewares
adminRouter.post("/add-product", admin, addProduct);

adminRouter.get("/get-products", admin, getProducts);

adminRouter.post("/delete-product", admin, deleteProduct);

adminRouter.get("/get-orders", admin, fetchAllOrders);

adminRouter.post("/change-status", admin, changeStatus);

adminRouter.get("/analytics", admin, getAnalytics);

module.exports = { adminRouter };
