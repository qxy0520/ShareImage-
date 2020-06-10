const mysql = require('mysql');

let pool = mysql.createPool({
    connectionLimit: 50,
    host: '127.0.0.1',
    user: 'root',
    password: 'q65j07l28?!',
    database: 'imageshare'
});


//执行代码，返回执行结果
var execute = (sql, ...params) => {
    return new Promise(function (resolve, reject) {
        pool.getConnection(function (err, connection) {
            if (err) {
                reject(err);
                return;
            }
            console.log(sql)
            // query方法会自动处理sql注入
            connection.query(sql, params, function (error, res) {
                connection.release();
                if (error) {
                    reject(error);
                    return;
                }
                resolve(res);
            });
        });
    });
}

module.exports = {
    execute: execute
};