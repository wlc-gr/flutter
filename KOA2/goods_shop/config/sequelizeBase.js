//引入sequelize
const {Sequelize} = require('sequelize');
const sequelize = new Sequelize('postgres', 'postgres', '123456', {
    logging: (...msg) => console.log(msg),//开启控制台打印SQL
    host: 'localhost',//
    dialect: "postgres", //数据库方言
    pool: {
        max: 50,
        min: 10,
        idle: 30000
    },
});

// 测试数据数据是否连接成功
// (async ()=>{
//     try {
//         await sequelize.authenticate();
//         console.log('Connection has been established successfully.');
//     } catch (error) {
//         console.error('Unable to connect to the database:', error);
//     }
// })();

//默认暴露 sequelize
module.exports = sequelize;
