const { Product } = require("../models/product");
const Order = require("../models/order");
exports.addProduct = async (req, res) => {
  try {
    const { name, description, quantity, images, category, price } = req.body;
    let product = new Product({
      name,
      description,
      quantity,
      images,
      category,
      price,
    });
    product = await product.save();
    res.json(product);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

exports.getProducts = async (req, res) => {
  try {
    const products = await Product.find({});
    res.json(products);
  } catch (error) {
    res.status(500).json({ error: err.message });
  }
};

exports.deleteProduct = async (req, res) => {
  try {
    const { _id } = req.body;
    let product = await Product.findById(_id).then((product) => {
      if (product) {
        return Product.findByIdAndDelete(_id);
      } else {
        res.status(404).json({ msg: "product not found" });
      }
    });
    // let product=await Product.findByIdAndRemove(_id);

    // product = product.save();
    res.json(product);
  } catch (error) {
    res.status(500).json({ error: err.message });
  }
};

exports.fetchAllOrders = async (req, res) => {
  await Order.find()
    .then((orders) => {
      console.log(orders);
      res.json(orders);
    })
    .catch((err) => {
      res.status(500).json({ error: err.message });
    });
};

exports.changeStatus = async (req, res) => {
  const { status, orderId } = req.body;

  console.log(status);
  console.log(orderId);

  await Order.findOne({ _id: orderId })
    .then((order) => {
      console.log(order);
      order.status = status;
      order.save();
    })
    .catch((err) => {
      res.status(500).json({ error: err.message });
    });
};

exports.getAnalytics = async (req, res) => {
  let totalEarnings = 0;
  await Order.find()
    .then((orders) => {
      console.log("from analytics" + orders[0].products[0].product);
      for (let i = 0; i < orders.length; i++) {
        for (let j = 0; j < orders[i].products.length; j++) {
          totalEarnings +=
            orders[i].products[j].product["quantity"] *
            orders[i].products[j].product["price"];
        }
      }
    })
    .catch((err) => {
      res.status(500).json({ error: err.message });
    });
  let mobileCategories = await fetchCategoryWiseProduct("Mobiles");
  let EssentialsCategories = await fetchCategoryWiseProduct("Essentials");
  let AppliancesCategories = await fetchCategoryWiseProduct("Appliances");
  let BooksCategories = await fetchCategoryWiseProduct("Books");
  let FashionCategories = await fetchCategoryWiseProduct("Fashion");

  let earnings = {
    totalEarnings,
    mobileCategories,
    EssentialsCategories,
    AppliancesCategories,
    BooksCategories,
    FashionCategories,
  };
  res.json(earnings);
};

async function fetchCategoryWiseProduct(category) {
  let categoryEarnings = 0;

  await Order.find({
    "products.product.category": category,
  })
    .then((categoryOrders) => {
      // if (orders.length == 0) {
      //   return;
      // }
      for (let i = 0; i < categoryOrders.length; i++) {
        for (let j = 0; categoryOrders[i].products.length; j++) {
          // console.log(orders[i].products[j].product.quantity);
          // console.log(orders[i].products[j].product.price);
          if (categoryOrders[i].products[j].product.category == category) {
            categoryEarnings +=
              categoryOrders[i].products[j].product.quantity *
              categoryOrders[i].products[j].product.price;
          }
        }
      }
    })
    .catch((err) => {
      console.log(err);
    });

  return categoryEarnings;
}
