var express = require('express');
var router = express.Router();
var picModel = require('../model/picModel');
var userModel = require('../model/userModel');

// 获取登录页面
router.get('/login', function (req, res, next) {
  res.render('login');
})
// 登录实现
router.post('/login', async function (req, res, next) {
  var username = req.body.username;
  var password = req.body.password;
  let rs = await userModel.login(username, password);
  rs = JSON.parse(JSON.stringify(rs));
  if(rs[0]) {
    req.session.user = rs[0];
    res.redirect('/');
  } else {
    res.send('<p>Wrong Username or password!</p>')
  }
})

router.get('/register', function (req, res, next) {
  res.render('register');
})

router.post('/register', async function (req, res, next) {
  var username = req.body.username;
  var password = req.body.password;
  var repwd = req.body.repwd;
  if(repwd.trim() != password.trim()) {
    res.send('<p>Two passwords are inconsistent</p>')
  }
  let check = await userModel.registeCheck(username);
  if(!check) {
    let rs = await userModel.register(username, password);
    if(rs) {
      res.redirect('/users/login');
    } 
  } else {
    res.send('Change another username and try again!');
  }
})

router.get('/logout', function (req, res, next) {
  req.session.destroy();
  res.redirect('/')
})
module.exports = router;
