const fs = require('fs');

class 岸 {
    constructor(野人, 传道士, 船) {
        this.野人 = 野人;
        this.传道士 = 传道士;
        this.船 = 船
    };
    船运(运到, 运野人, 运传道士) {
        if (this.船 > 0) {
            console.log('运输中');
            this.野人 -= 运野人
            this.传道士 -= 运传道士
            //TODO check
            运到.野人 += 运野人
            运到.传道士 += 运传道士
        }
    }
    toString() {
        return String(this.传道士) + String(this.野人) + this.船
    }
}

class 状态空间 {
    constructor(左岸, 层, parent) {
        this.parent = parent;
        this.层 = 层;
        this.左岸 = 左岸;
        this.右岸 = new 岸(3 - 左岸.野人, 3 - 左岸.传道士, 1 - 左岸.船)
    }
    check() {
        return (this.左岸.野人 <= this.左岸.传道士 || this.左岸.传道士 === 0)
            && (this.右岸.野人 <= this.右岸.传道士 || this.右岸.传道士 === 0)
    }
    success() {
        return this.左岸.野人 === 0 && this.左岸.传道士 === 0
    }
    船运(运量) {
        const flag = this.右岸.船 ? 1 : -1;
        const a = this.左岸.野人 + flag * 运量[0];
        const b = this.左岸.传道士 + flag * 运量[1];
        const 运后左岸 = new 岸(a, b, this.左岸.船 + flag)
        const 新状态 = new 状态空间(运后左岸, this.层 + 1, this);
        if (a >= 0 && b >= 0 && 新状态.check()) {
            return 新状态;
        } else {
            return undefined;
        }
    }
    next() {
        const 运法 = [[1, 0], [0, 1], [1, 1], [2, 0], [0, 2]];//一共五种可能的运法
        const output = 运法.map(
            运 => this.船运(运)
        )
        return output.filter(val => val);
    }
    toString() {
        if (this.parent) {
            return this.parent.toString() + '-->' + this.左岸.toString() + '-' + this.层
        }
        return this.左岸.toString() + '-' + this.层
    }
}
const arg2 = process.argv[2];
const limit = Number(arg2);
const 路径长度限制 = limit > 0 ? limit : 11;

const 初始状态 = new 状态空间(new 岸(3, 3, 1), 0);
let 打印文本 = "", 计数 = 0, 路径计数 = 0, 层计数 = new Array(路径长度限制 + 1).fill(0);
function rec(a) {
    const 状态集 = a.next();
    for (const val of 状态集) {
        if (val.success()) {
            打印文本 += `%%${String(++计数)}:\n` + val.toString() + '\n';
            层计数[val.层]++;
            ++路径计数
            continue;
        }
        if (val.层 > 路径长度限制) {
            ++路径计数
            continue;
        }
        rec(val);
    }
}
rec(初始状态);
let 总合格路径数 = 0;
const log=层计数.reduce(
    (pre, cur, idx) => {
        if (cur > 0) {
            总合格路径数 += cur;
            return pre += `路径长度为${idx}的结果找到了${cur}个\n`
        }
        if (pre === 0) {
            return ""
        }
        return pre
    }
);
const rate=总合格路径数/路径计数;
console.log(`${log}\n总合格路径数/路径计数=${rate*100}%`)


fs.writeFileSync('mermaid.md', '```mermaid\ngraph TB\n' + 打印文本 + '\n```')