const jwt = require("jsonwebtoken");
const { model } = require("mongoose");
const User = require("../models/user");

const admin = async (req, res, next) => {
  try {
    const token = req.header("x-auth-token");
    if (!token)
      return res.status(401).json({ msg: "No auth token,access denied" });

    const verified = jwt.verify(token, "passwordKey");
    const user = await User.findById(verified.id);
    if (user.type == "user" || user.type == "seller") {
      return res.status(401).json({ msg: "you are not an admin!" });
    }
    req.user = verified.id;
    req.token = verified.token;
    next();
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

module.exports = admin;
