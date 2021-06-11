//一个使用javascript写的计算二阶系统动态响应特性的脚本
class Sys {
    pi = Math.PI
    fix = (x) => x.toFixed(2)
    constructor(xi, omega_n,pi) {
        if(pi){this.pi=pi}
        this.xi = xi;
        this.omega_n = omega_n;
        this.omega_d = this.omega_n * Math.sqrt(1 - this.xi * this.xi);
        this.beta = Math.acos(this.xi);
        this.sigma = this.omega_n * this.xi;
    }
    info(fix) {
        if (fix === undefined) {
            fix = this.fix
        }
        let str = `二阶系统：
        闭环传递函数：
            ${fix(this.omega_n**2)}
        --------------------------
        s^2+2${fix(this.xi*this.omega_n)}+${fix(this.omega_n**2)}
        开环传递函数：
            ${fix(this.omega_n**2)}
        ---------------------
        s(s+2${fix(this.xi*this.omega_n)})
        阻尼比：${fix(this.xi)}
        阻尼角：${fix(this.beta)}
        自然频率：${fix(this.omega_n)}`
        console.log(str);
    }
    step(fix) {
        if (fix === undefined) {
            fix = this.fix
        }
        let str = `阶跃响应动态特性：
        上升时间：${fix(this.t_r())}
        峰值时间：${fix(this.t_p())}
        超调量：  ${fix(this.sigmaPercent())}
        调节时间：
            4/sigma:   ${fix(this.t_s())}
            3.5/sigma: ${fix(this.t_s5p())}(0.05误差带)
            4.4/sigma：${fix(this.t_s2p())}(0.02误差带)`
        console.log(str)
    }
    t_r() {
        const compute = (sys) => (sys.pi - sys.beta) / sys.omega_d;
        return compute(this);
    }
    t_p() {
        const compute = (sys) => (sys.pi) / sys.omega_d;
        return compute(this);
    }
    sigmaPercent() {
        const compute = (sys) => {
            let idxA = -sys.pi * sys.xi;
            let idxB = Math.sqrt(1 - sys.xi * sys.xi);
            return Math.E ** (idxA / idxB);
        }
        return compute(this);
    }
    t_s() {
        const compute = (sys) => 4 / sys.sigma;
        return compute(this);
    }
    t_s5p() {
        const compute = (sys) => 3.5 / sys.sigma;
        return compute(this);
    }
    t_s2p() {
        const compute = (sys) => 4.4 / sys.sigma;
        return compute(this);
    }

}
//计算考试题的最后一题，
//我是笨蛋，保留小数都保留错了，特地来吧程序里面增加了小数处理的功能
let ln03 = - Math.log(0.3);
let pi =Math.PI// 4 * Math.atan(1);

//根据超调量计算阻尼比
let xi = Math.sqrt(ln03 * ln03 / (pi * pi + ln03 * ln03))
console.log("算得阻尼比：",xi)

//根据阻尼比和峰值时间计算自然频率
const omega_n = (xi) => {
    let t_p=0.1
    let n = Math.sqrt(1 - xi * xi);
    return pi / n /t_p
}
console.log("阻尼比0.32和0.35和实际值下的自然频率: \n",omega_n(0.32), omega_n(0.35),omega_n(xi))

//给出系统的具体参数
let sys = new Sys(xi, omega_n(xi));
sys.info();
sys.step();

