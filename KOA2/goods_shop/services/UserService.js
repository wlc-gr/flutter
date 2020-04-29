//导入
const UserModel = require('../models/UserModel');
const DBError = require('../utils/DBError');
const ResponseCodes = require('../utils/ResponseCodes');

/**
 * 员工管理查询
 */
class UserService {

    /**
     * 查询所有的员工信息
     * @returns {Promise<Model[]>}
     */
    static queryAll() {
        return UserModel.findAll();
    }

    /**
     * 查询用户信息
     * @param name  姓名
     * @returns {Promise.<*>}
     */
    static async findUserByName(name) {
        try {
            const userInfo = await UserModel.findOne({
                where: {
                    name
                }
            })
            return userInfo;
        } catch (err) {
            throw new DBError(ResponseCodes.DBERROR, err);
        }
    }

    /**
     * 创建用户
     * @param user
     * @returns {Promise.<boolean>}
     */
    static async createUser(user) {
        try {
            let rows = await UserModel.create(user);
            return rows;
        } catch (err) {
            throw new DBError(ResponseCodes.DBERROR, err);
        }
    }

    /**
     * 判断用户邮箱是否已经注册
     * @param email
     * @returns {Promise<void>}
     */
    static async getUserByEmail(email) {
        try {
            const user = await UserModel.findOne({
                where: {
                    email
                }
            });
            console.log('-------------->'+user)
            return user;
        } catch (error) {
            console.log(error)
            throw new DBError(ResponseCodes.DBERROR, error);
        }
    }

}

//暴露服务
module.exports = UserService;
