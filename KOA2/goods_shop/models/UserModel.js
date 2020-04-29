//引入映射的数据类型
const {Sequelize, DataTypes} = require('sequelize');
//导入数据库连接
const sequelize = require('../config/sequelizeBase');
//定义数据模型
const UserModel = sequelize.define('user', {
    id: {
        type: DataTypes.UUID,
        defaultValue: Sequelize.UUIDV4,
        primaryKey: true, // 主键
        allowNull: false,   //不为空
        unique: true,
        comment: '数据id', // 说明
    },
    account: {
        type: DataTypes.STRING,
        allowNull: false,
        comment: ' 用户账号'
    },
    name: {
        type: DataTypes.STRING,
        comment: '用户名称',
    },
    password: {
        type: DataTypes.STRING(32),
        allowNull: false,
        comment: "用户密码",
    },
    phone: {
        type: DataTypes.STRING(11),
        allowNull: true,
        comment: '用户电话',
        // validate:电话号码格式校验 TODO
    },
    createtime: {
        type: DataTypes.DATE,
        defaultValue: new Date(),
        comment: "创建时间"
    },
    createuser: {
        type: DataTypes.STRING(255),
        comment: '创建人',
    },
    updatetime: {
        type: DataTypes.DATE,
        defaultValue: new Date(),
        comment: "修改时间"
    },
    updateuser: {
        type: DataTypes.STRING,
        comment: '修改人'
    },
    del: {
        type: DataTypes.BOOLEAN,
        defaultValue: false,
        comment: '是否已经删除'
    }
}, {
    timestamps: false,
    tableName: 't_user'
});

module.exports = UserModel;
