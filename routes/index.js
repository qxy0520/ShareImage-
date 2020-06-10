var express = require('express');
var router = express.Router();
var picModel = require('../model/picModel');

function formatDate(millinSeconds) {
  var date = new Date(millinSeconds);
  var monthArr = new Array("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Spt", "Oct", "Nov", "Dec");
  var suffix = new Array("st", "nd", "rd", "th");

  var year = date.getFullYear(); //年
  var month = monthArr[date.getMonth()]; //月
  var ddate = date.getDate(); //日

  if (ddate % 10 < 1 || ddate % 10 > 3) {
    ddate = ddate + suffix[3];
  } else if (ddate % 10 == 1) {
    ddate = ddate + suffix[0];
  } else if (ddate % 10 == 2) {
    ddate = ddate + suffix[1];
  } else {
    ddate = ddate + suffix[2];
  }
  return ddate + " " + month + " " + year;
}

/* GET home page. */
router.get('/', async function(req, res, next) {
  // 查询所有的图片
  let rs = await picModel.getAllPic();
  rs.map((item, index) => {
    // 格式化时间格式
    item.picture_time = formatDate(new Date(item.picture_time));
    return item;
  });
  
  let user = req.session.user;
  // 查询当前用户是否喜欢这个图片
  if(user) {
    for(let i = 0; i < rs.length; i++) {
      let iflike = await picModel.iflikeThisPic(user.user_id, rs[i].picture_id);
      // 设置标志位
      if(iflike) {
          rs[i].likeyes = true;
      } else {
          rs[i].likeyes = false;
      }
    }
  }
  // console.log('user is')
  // console.log(user)
  res.render('index', { picMessages: JSON.stringify(rs), username: user ? user.user_name : '' });
});

module.exports = router;
