const { Product } = require("../models/product");

exports.getProducts = async (req, res) => {
  try {
    const products = await Product.find({ category: req.query.category });
    res.json(products);
  } catch (error) {
    res.status(500).json({ error: err.message });
  }
};

exports.rateProducts = async (req, res) => {
  try {
    const { id, rating } = req.body;
    let product = await Product.findById(id);
    for (let i = 0; i < product.rating.length; i++) {
      if (product.rating[i].userId == req.user) {
        product.rating.splice(i, 1);
        break;
      }
    }
    const ratingSchema = {
      userId: req.user,
      rating,
    };

    product.rating.push(ratingSchema);
    product = await product.save();
    res.json(product);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

exports.getDealofDay = async (req, res) => {
  try {
    let product = await Product.find({});

    product = product.sort((a, b) => {
      let aSum = 0;
      let bSum = 0;

      for (let i = 0; i < a.rating.length; i++) {
        aSum += a.rating[i].rating;
      }
      for (let i = 0; i < b.rating.length; i++) {
        bSum += b.rating[i].rating;
      }
      return aSum < bSum ? 1 : -1;
    });
    res.json(product[0]);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};
