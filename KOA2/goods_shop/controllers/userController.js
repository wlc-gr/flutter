const UserService = require('../services/UserService');
const jwt = require('jsonwebtoken');
const bcrypt = require('bcryptjs');
const salt = bcrypt.genSaltSync(10);

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
    let user = ctx.request.body;
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
