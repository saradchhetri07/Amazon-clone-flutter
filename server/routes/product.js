const express = require("express");
const {
  getProducts,
  rateProducts,
  getDealofDay,
} = require("../controllers/productController");
const auth = require("../middlewares/auth");
const productRouter = express.Router();

productRouter.get("/api/products", auth, getProducts);

productRouter.post("/api/rate-products", auth, rateProducts);

productRouter.get("/api/deal-of-day", auth, getDealofDay);

module.exports = { productRouter };
