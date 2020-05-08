const router = require('koa-router')();
const userController = require('../controllers/userController');

const tools = require('../utils/tools');
//注册
router.post('/api/user/signup', userController.signup);
//登录
router.post('/api/user/login', userController.login);
//发送邮件
router.get('/api/user/verificationCode', userController.verificationCode);
//发送短信验证码
router.get('/api/user/sendcode', userController.sendcode);

//图片验证码
router.get('/api/user/captcha', userController.captcha);

router.get('/api/user/encode', async (ctx,next)=>{
    let param = ctx.request.body || {};
    Object.assign(param, ctx.request.query);
    tools.encode(param.text);
    ctx.body = {
        code: 10000,
        message: tools.encode(param.text)
    }
});

router.get('/api/user/decode', async (ctx,next)=>{
    let param = ctx.request.body || {};
    Object.assign(param, ctx.request.query);
    tools.encode(param.text);
    ctx.body = {
        code: 10000,
        message: tools.decode(param.text)
    }
});

module.exports = router;
