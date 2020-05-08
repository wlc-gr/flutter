const UserService = require('../services/UserService');
const jwt = require('jsonwebtoken');
const bcrypt = require('bcryptjs');
const salt = bcrypt.genSaltSync(10);
const EmailUtils = require('../utils/emailUtils');//发送邮件服务
const sms_util = require('../utils/sms_util');//发送短信服务
const validator = require('validatorjs');//基本验证器
const svgCaptcha = require('svg-captcha');//svg图片验证码

/**
 * 用户注册
 * @param ctx
 * @returns {Promise<void>}
 */
exports.signup = async (ctx) => {
    //用户密码加密
    const hashPwd = bcrypt.hashSync(ctx.request.body.pwd, salt);
    const user = {
        email: ctx.request.body.email,
        pwd: hashPwd,
        name: ctx.request.body.name,
        phone: ctx.request.body.phone,
    };
    //验证邮箱唯一性
    const emailUniq = UserService.getUserByEmail(ctx.request.body.email);
    //如果已经存在
    if (emailUniq) {
        ctx.body = {
            code: 10000,
            message: '该邮箱已被注册'
        };
        return;
    }

    //验证昵称唯一性
    const nicknameUniq = UserService.findUserByName(ctx.request.body.name);
    //如果已经存在
    if (nicknameUniq) {
        ctx.body = {
            code: 10000,
            message: '该昵称已被注册'
        }
        return;
    }

    //插入数据
    const res = UserService.createUser(user);
    const token = jwt.sign(res.id, 'chambers');
    ctx.body = {
        code: 0,
        data: {
            name: res.name,
            token: token
        }
    }
}

/**
 * 用户登录
 * @param ctx
 * @returns {Promise<void>}
 */
exports.login = async (ctx) => {
    let user = ctx.request.body || {};
    Object.assign(user, ctx.request.query);
    const emailSigned = await UserService.getUserByEmail(user.email);
    //如果不存在
    if (!emailSigned) {
        ctx.body = {
            code: 10000,
            message: '该邮箱还没注册，请前往注册'
        };
        return;
    }
    //已经存在
    else {
        //密码不对
        if (!bcrypt.compareSync(user.pwd, emailSigned.pwd)) {
            ctx.body = {
                code: 10000,
                message: '密码不正确'
            };
            return;
        }
        //密码正确
        else {
            const token = jwt.sign(emailSigned.id, 'chambers');
            ctx.body = {
                code: 0,
                data: {
                    name: emailSigned.name,
                    token: token
                },
            }
        }
    }
}

/**
 * 发送邮件注册验证码
 * @param ctx
 * @returns {Promise<void>}
 */
exports.verificationCode = async (ctx) => {
    let emailInfo = ctx.request.query;
    if (!emailInfo.email) {
        ctx.body = {
            code: 10000,
            message: '请填写发送邮件地址!'
        };
        return;
    }
    EmailUtils.getInstance().sendEmil(emailInfo.email, emailInfo.subject, emailInfo.user, '66666', emailInfo.shopname, function (error, info) {
        if (error) {
            ctx.body = {
                code: 10000,
                message: '发送邮件失败'
            };
        }
    });
    ctx.body = {
        code: 10000,
        message: '发送邮件失败'
    };
}

/*发送短信服务 费用已完*/

function isTelCode(str) {
    var reg = /^((0\d{2,3}-\d{7,8})|(1[3584]\d{9}))$/;
    return reg.test(str);
}

exports.sendcode = async (ctx, next) => {
    let param = ctx.request.body || {};
    Object.assign(param, ctx.request.query);
    let phone = param.phone;
    //2. 校验数据
    if (!isTelCode(phone)) {
        ctx.body = {
            code: 10000,
            message: '输入的手机号码有误'
        };
        return;
    }
    //生成验证码(6位随机数)
    var code = sms_util.randomCode(6);
    //发送给指定的手机号
    console.log(`向${phone}发送验证码短信: ${code}`);
    console.log('--------------==')
    await sms_util.sendCode(phone, code, function (success) {//success表示是否成功
        if (success) {
            // users[phone] = code
            // console.log('保存验证码: ', phone, code)
            ctx.body = {
                code: 0,
                message: '手机验证码发送成功'
            };
        } else {
            //3. 返回响应数据
            ctx.body = {
                code: 10000,
                message: '短信验证码发送失败'
            };
        }
    })
}

/*图片验证码*/
exports.captcha = async (ctx, next) => {
    let captcha = await svgCaptcha.create({
        ignoreChars: '0o1l',
        noise: 6,
        color: true
    });
    console.log(captcha.data);
    //ctx.response.type='svg';
    ctx.body = {
        code: 10000,
        message: captcha.data
    };
    next();
}

