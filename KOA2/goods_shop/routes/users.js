const router = require('koa-router')();
const userController = require('../controllers/userController');
//注册
router.post('/api/user/signup', userController.signup);

//登录
router.post('/api/user/login', userController.login);

module.exports = router;
