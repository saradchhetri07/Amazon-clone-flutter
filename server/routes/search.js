const express = require("express");
const { searchProducts } = require("../controllers/searchController");
const auth = require("../middlewares/auth");

const searchRouter = express.Router();

searchRouter.get("/api/products/search/:name", auth, searchProducts);

module.exports = { searchRouter };
