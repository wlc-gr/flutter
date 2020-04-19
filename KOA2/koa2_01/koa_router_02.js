const Koa = require("koa");
const Router = require('koa-router');//路由解析
const views = require('koa-views');//模板引擎
const bodyparser = require('koa-bodyparser');//解析post请求
const serve  = require('koa-static');//静态文件处理中间件
const session2 = require('koa-session2');
const Store = require('./config/RedisForSession');
const {SESSION_KEY} = require('./config/BaseConstant');


const app = new Koa();
const router = new Router();
//必须配置在所有的中间之前
app.use(views(__dirname + '/views', {extension: 'ejs'}));
//配置bodyparser解析request
app.use(bodyparser());
//session处理
// app.keys = ['some secret hurr'];
// const CONFIG = {
//     key: 'koa:sess', /** (string) cookie key (default is koa:sess) */
//     /** (number || 'session') maxAge in ms (default is 1 days) */
//     /** 'session' will result in a cookie that expires when session/browser is closed */
//     /** Warning: If a session cookie is stolen, this cookie will never expire */
//     maxAge: 10000,
//     autoCommit: true, /** (boolean) automatically commit headers (default true) */
//     overwrite: true, /** (boolean) can overwrite or not (default true) */
//     httpOnly: true, /** (boolean) httpOnly or not (default true) */
//     signed: true, /** (boolean) signed or not (default true) */
//     rolling: true, /** (boolean) Force a session identifier cookie to be set on every response. The expiration is reset to the original maxAge, resetting the expiration countdown. (default is false) */
//     renew: false, /** (boolean) renew session when session is nearly expired, so we can always keep user logged in. (default is false)*/
//     sameSite: null, /** (string) session cookie sameSite options (default null, don't set it) */
// };
//
// app.use(session(CONFIG, app));//设置session

//使用session2中间件
app.use(session2({
    key: SESSION_KEY,
    store: new Store(),
}));

//配置进度文件中间件
app.use(serve(__dirname+'/public'));
//使用中间件
app.use(async (ctx, next) => {
    console.log('欢迎使用Koa2!');
    await next();
});
/*
* Koa GET传值
*  可以通过 ctx.query
*          ctx.querystring
*   或者使用  ctx.request.query
*            ctx.request.querystring
* */
router.get('/login', async (ctx, next) => {
    console.log(ctx.query);
    console.log(ctx.querystring);
    ctx.body = '您正在使用登录接口!';
    ctx.session.user={'user':'WANGLAICAI','msg':'GR I LOVY YOU'};
    await next();
});
/*
* Koa2动态路由
* */
router.get('/users/:uid', async (ctx, next) => {
    console.log(ctx.params);
    ctx.body = '你正在使用Koa动态路由!';
    console.log(ctx.session.user);
    await next();
});

router.get('/get_add',(ctx,next)=>{
   ctx.render('add.ejs')
});

router.get('/add',(ctx,next)=>{
   ctx.body = ctx.request.body;
});

//启动路由
app.use(router.routes());
app.use(router.allowedMethods());


app.listen(3000);
