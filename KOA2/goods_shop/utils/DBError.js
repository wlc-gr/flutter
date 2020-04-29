//定义数据库查询异常
class DBError extends Error{
    //构造方法
    constructor(code,error){
        super();

        this.error = error;
        this.code = code;
    }
}
module.exports = DBError;
