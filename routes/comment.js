var express = require('express');
var router = express.Router();
var picModel = require('../model/picModel');
var commentModel = require('../model/commentModel');
 



router.post('/add', async function (req, res, next) {
    console.log(req.body)
    console.log(req.session.user)
    let rs = await commentModel.addComment(req.session.user.user_id, req.body.picture_id, req.body.commentText);
    if(rs) {
        res.json({
            message: 'succeed'
        })
    } else {
        res.json({
            message: 'failed'
        })
    }
})

module.exports = router;