const User = require("../models/user");
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");

exports.signUp = async (req, res) => {
  try {
    const { email, username, password } = req.body;

    const existingUser = await User.findOne({ email });

    if (existingUser) {
      return res
        .status(400)
        .json({ msg: "User with same email already exists" });
    }
    const hasedPassword = await bcrypt.hash(password, 10);

    let user = new User({
      username: username,
      email: email,
      password: hasedPassword,
    });
    user = await user.save();
    res.json(user);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
  //receive from client

  //store to database
  //send response to client
};

exports.signIn = async (req, res) => {
  try {
    const { email, password } = req.body;

    const user = await User.findOne({ email });

    if (!user) {
      return res.status(400).json({ msg: "User doesn't exist" });
    }
    const isMatch = await bcrypt.compare(password, user.password);
    if (!isMatch) {
      return res.status(400).json({ msg: "Invalid Password" });
    }
    const token = await jwt.sign({ id: user._id }, "passwordKey");
    res.json({ token, ...user._doc });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
  //receive from client

  //store to database
  //send response to client
};

exports.checkToken = async (req, res) => {
  try {
    const token = req.header("x-auth-token");
    if (!token) return res.json(false);
    const verifyToken = jwt.verify(token, "passwordKey");
    if (!verifyToken) return res.json(false);
    const findTokenUser = await User.findById(verifyToken.id);
    if (!findTokenUser) return res.json(false);
    return res.json(true);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

exports.logInUser = async (req, res) => {
  const user = await User.findById(req.user);
  // console.log({ ...user._doc });
  res.json({ ...user._doc, token: req.token });
};
