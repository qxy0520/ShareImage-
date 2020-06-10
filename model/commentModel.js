const db = require('../tools/db');

const sql = {
    addComment: 'insert into comment(user_user_id, picture_picture_id, comment_content) values(?,?,?)',
    getOnePicComment: 'select * from comment a inner join user b on a.user_user_id = b.user_id and a.picture_picture_id = ? order by a.comment_id desc'
}

const commentModel = {
    addComment: async (...params) => {
        let rs = await db.execute(sql.addComment, ...params);
        console.log(rs);
        rs = JSON.parse(JSON.stringify(rs));
        if (rs.insertId) {
            return true;
        }
        return false;
    },
    getOnePicComment: async (...params) => {
        let rs = await db.execute(sql.getOnePicComment, ...params);
        rs = JSON.parse(JSON.stringify(rs));
        return rs;
    }
}

module.exports = commentModel;