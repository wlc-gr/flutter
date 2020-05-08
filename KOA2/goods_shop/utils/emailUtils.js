//导入邮件发送服务
const nodemailer = require('nodemailer');
const {EMAIL_HOST, EMAIL_PROT, EMAIL_USER, EMAIL_PWD} = require('../config/constant');

class EmailUtils {
    constructor(host, port, user, pass) {
        //设置邮箱配置
        this.transporter = nodemailer.createTransport({
            host: host,//邮箱服务的主机，如smtp.qq.com
            port: port,//对应的端口号
            //开启安全连接
            secure: false,
            //secureConnection:false,
            //用户信息
            auth: {
                user: user,
                pass: pass
            }
        });
    }

    static getInstance() {
        if (!EmailUtils.instance) {
            EmailUtils.instance = new EmailUtils(EMAIL_HOST, EMAIL_PROT, EMAIL_USER, EMAIL_PWD);
        }
        return this.instance;
    }

    //发送邮件验证码
    sendEmil(toEmail, subject = '文鸯商城注册验证码', username, verificationCode, shopname = '文鸯商城', callback) {
        console.log(toEmail)
        let text = `<h1>尊敬的${username}用户您好！</h1> 
                    <h1>您的验证码为：${verificationCode} 。请在3分钟内完成注册。</h1>
                    <h1>欢迎关注${shopname}!</h1>
                    `;
        //设置收件人信息
        let mailOptions = {
            from: constant.EMAIL_USER,//谁发的
            to: toEmail,//发给谁
            subject: subject,//主题是什么
            // text:text,//文本内容
            html: text,//html模板
            // //附件信息
            // attachments:[
            //     {
            //         filename:'',
            //         path:'',
            //     }
            // ]
        };
        this.transporter.sendMail(mailOptions, callback);
    }
}

//暴露邮件发送功能
module.exports = EmailUtils;
