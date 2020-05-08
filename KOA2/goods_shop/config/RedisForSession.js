const Redis = require('ioredis');
const {Store} = require('koa-session2');
const {SESSION_KEY} = require('./constant');

class RedisForSession extends Store {
    constructor() {
        super();
        this.redis = new Redis();
    }
    async get(sid, ctx) {
        let data = await this.redis.get(`${SESSION_KEY}:${sid}`);
        return JSON.parse(data);
    }
    async set(session, {sid = this.getID(24), maxAge = 1000000} = {}, ctx) {
        try {
            // Use redis set EX to automatically drop expired sessions
            await this.redis.set(`${SESSION_KEY}:${sid}`, JSON.stringify(session), 'EX', maxAge / 1000);
        } catch (e) {
        }
        return sid;
    }
    async destroy(sid, ctx) {
        return await this.redis.del(`${SESSION_KEY}:${sid}`);
    }
}

module.exports = RedisForSession;
