const Koa = require('koa');
const app = new Koa();
// const views = require('koa-views');
const json = require('koa-json');
const onerror = require('koa-onerror');
const bodyparser = require('koa-bodyparser');
const logger = require('koa-logger');
const jwt = require('koa-jwt');
const cors = require('koa2-cors');
const DBError = require('./utils/DBError');
const session2 = require('koa-session2');

//导入路由
const users = require('./routes/users');

//处理数据库异常中间件
// app.use(async (ctx, next) => {
//     try {
//         //先去执行路由
//         await next();
//     } catch (error) {
//         if (error instanceof DBError) {
//             ctx.status = 200;
//             ctx.error(error.code, error.error);
//         }
//         //继续抛，让外层中间件处理日志
//         throw error;
//     }
// });


// error handler
onerror(app);
//配置浏览器跨域
app.use(cors({
    origin: '*',
    exposeHeaders: ['WWW-Authenticate', 'Server-Authorization'],
    maxAge: 5,
    credentials: true,
    allowMethods: ['GET', 'POST', 'DELETE'],
    allowHeaders: ['Content-Type', 'Authorization', 'Accept'],
}));
//请求参数解析
app.use(bodyparser({
    enableTypes: ['json', 'form', 'text']
}));
//配置session共享
app.use(session2({
    key: SESSION_KEY,
    store: new Store(),
}));
app.use(json());
app.use(logger());
//配置静态资源中间件
app.use(require('koa-static')(__dirname + '/public'));
//配置模板地址中间件
// app.use(views(__dirname + '/views', {
//     extension: 'ejs'
// }));

// 打印请求过程时间中间件
app.use(async (ctx, next) => {
    const start = new Date()
    await next()
    const ms = new Date() - start
    console.log(`${ctx.method} ${ctx.url} - ${ms}ms`);
});
//配置jwt中间件
app.use(jwt({
    secret: 'chambers'
}).unless({path: [/^\/api/]}));
// 配置路由中间件
app.use(users.routes(), users.allowedMethods());

// error-handling
app.on('error', (err, ctx) => {
    console.error('server error', err, ctx)
});

module.exports = app;
