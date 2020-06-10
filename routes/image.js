var express = require('express');
var router = express.Router();
var multer = require('multer')
var fs = require('fs')
var picModel = require('../model/picModel');
var commentModel = require('../model/commentModel');

const uploads = multer({ dest: 'public/images' })	
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

router.get('/:id', async function (req, res, next) {
    let picture_id = req.params.id;
    let rs = await picModel.getOnePic(picture_id);
    let user = req.session.user;
    rs[0].picture_time = formatDate(new Date(rs[0].picture_time));

    if(user) {
        let cc = await picModel.iflikeThisPic(user.user_id, picture_id);
        if(cc) {
            rs[0].likeyes = true;
        } else {
            rs[0].likeyes = false;
        }
    }
    let comments = await commentModel.getOnePicComment(picture_id);
    res.render('image', {item: rs[0], username: user ? user.user_name : '', comments: comments})
})

router.post('/dislike', async function (req, res, next) {
    const picture_id = req.body.picture_id;
    let rs = picModel.dislikePic(req.session.user.user_id, picture_id);
    if(rs) {
        res.json({
            message: 'succeed'
        });
    } else {
        res.json({
            message: 'failed'
        })
    }
})
router.post('/like', async function (req, res, next) {
    const picture_id = req.body.picture_id;
    let rs = picModel.likePic(req.session.user.user_id, picture_id);
    if (rs) {
        res.json({
            message: 'succeed'
        });
    } else {
        res.json({
            message: 'failed'
        })
    }
})

router.get('/up/image', function (req, res, next) {
    res.render('upload', {username: req.session.user.user_name});
})

router.post('/upload', uploads.single('file'), function (req, res, next) {
    var file = req.file;
    let fileInfo = {};
    console.log(file);
    fs.renameSync('public/images/' + file.filename, 'public/images/' + file.originalname);//这里修改文件名字，比较随意。
    // 获取文件信息
    fileInfo.mimetype = file.mimetype;
    fileInfo.originalname = file.originalname;
    fileInfo.size = file.size;
    fileInfo.path = file.path;

    let rs = picModel.addPic(req.session.user.user_id, '/images/' + file.originalname);
    if (rs) {
        res.send("<p>Upload succeed, Go to <a href='/'>Home</a></p>")
    } else {
        res.send("<p>Upload failed, Go to <a href='/'>Home</a></p>")
    }
})
module.exports = router;