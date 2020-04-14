const Koa = require("koa");
const Router = require('koa-router');
const views = require('koa-views');
const app = new Koa();
const router = new Router();
//必须配置在所有的中间之前
app.use(views(__dirname + '/views', {extension: 'ejs'}));
//使用中间件
app.use(async (ctx, next) => {
    ctx.body = '欢迎使用Koa2!';
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
    await next();
});
/*
* Koa2动态路由
* */
router.get('/users/:uid', async (ctx, next) => {
    console.log(ctx.params);
    ctx.body = '你正在使用Koa动态路由!'
    await next();
});


//启动路由
app.use(router.routes());
app.use(router.allowedMethods());


app.listen(3000);
