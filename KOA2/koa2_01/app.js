//引入koa模块
const Koa = require('koa');
//创建koa APP实例
const app = new Koa();

//使用中间件

app.use(async(ctx,next)=>{
    ctx.body ='你好 ,Koa2s';
});
//监听3000端口
app.listen(3000);
