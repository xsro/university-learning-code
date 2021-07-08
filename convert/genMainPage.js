//generate the index.html main page
//and add a list to public/ folder for matlab to convert mlxs to htmls
//update lock file in convert/ folder

const fs = require('fs');
const path = require('path');
const parentDir = path.resolve(__dirname, '..');
let text = "";

/**scan folder for all mlx and ipynb */
function scan(folder) {
    const items = fs.readdirSync(folder)
    const output = [];
    //console.log(folder)
    for (const d of items) {
        const item = path.join(folder, d);
        const s = fs.statSync(item);
        if (s.isDirectory() && !d.startsWith('.')) {
            output.push(...scan(item));
        }
        else if ((s.isFile() && !d.startsWith('_')) && (d.endsWith('mlx') || d.endsWith('ipynb'))) {
            const re = path.relative(parentDir, item)
            output.push(re);
        }
    }
    return output;
}


const shrinkPath = path.resolve(parentDir, 'convert', 'mlx2html-lock.txt')
text = fs.existsSync(shrinkPath) ? fs.readFileSync(shrinkPath, { encoding: 'utf-8' }) : "";
const formerShrink = text.split('\n').map(val => {
    const a = val.split('\t');
    if (a.length >= 2) {
        const [num, path] = a;
        return { num: parseInt(num), path: path.trim() }
    }
}).filter(val => val)
let content = "";
let shrink = [];
let matlab = "";
let count = formerShrink.reduce((pre, cur) => pre < cur.num ? cur.num : pre, 0);

for (const f of fs.readdirSync(parentDir)) {
    const folder = path.join(parentDir, f);
    const s = fs.statSync(folder);
    if (s.isDirectory() && /\d.*/.test(f)) {
        content += "<h2>" + f + "</h2>\n";
        const files = scan(folder);
        const iterms = []
        for (const file of files) {
            const ext = path.extname(file);
            const fileRel = path.relative(parentDir, file).replace(/\\/g, '/');
            const fileRelNoExt = file.replace(ext, '')
            let dst = ""
            //process mlx files to make a shrink file for matlab to convert
            if (ext == '.mlx') {
                const s = formerShrink.find(val => val.path == fileRel);
                const number = s ? s.num : ++count;
                dst = 'm' + number + '.html'
                shrink.push({ number, fileRel });
                matlab += `${path.join(parentDir, file)}\t${path.join(parentDir, 'public', dst)}\n`
            }
            //process ipynb files to make a link to web
            else if (ext == '.ipynb') {
                dst = 'https://gitee.com/xsro/university-learning-code/tree/develop/' + fileRel;
            };
            const findItermIdx = iterms.findIndex(
                val => val.fileRelNoExt === fileRelNoExt
            )
            if (findItermIdx > 0) {
                iterms[findItermIdx].links.push({ ext, dst })
            } else {
                iterms.push(
                    { fileRelNoExt, links: [{ ext, dst }] }
                )
            }
        }
        const getNum = val => {
            const p = path.relative(folder, val);
            const s = p.match(/\d+/);
            return s ? parseInt(s[0]) : 200
        }
        const sortedIterms = iterms.sort((a, b) => getNum(a.fileRelNoExt) - getNum(b.fileRelNoExt))
        const contentText = sortedIterms.reduce(
            (pre, iterm) => {
                const linksText = iterm.links.reduce(
                    (prelink, link) => prelink + `<a href=${link.dst}>${link.ext.replace('.', '')}</a>\n`, ""
                )
                const name = path.relative(folder, iterm.fileRelNoExt);
                return pre + `<li>${name}: ${linksText}</li>`
            }, ""
        )
        content += '<ol>\n' + contentText + '</ol>';
    }
}

const html = fs.readFileSync(path.join(parentDir, 'convert/index.html'), { encoding: 'utf-8' });
fs.writeFileSync(path.join(parentDir, 'public/index.html'),
    html.replace("<div id='content'> </div>", "<div id='content'>" + content + " </div>"));
const compareShrink = function (a, b) {
    const res = a.number > b.number ? 1 : -1;
    return res
}
const shrinkText = shrink.sort(compareShrink).map(val => val.number + '\t' + val.fileRel).join('\n')
fs.writeFileSync(shrinkPath, shrinkText);
const MatlabTaskPath = path.join(parentDir, 'public', 'matlab_task.txt');
fs.writeFileSync(MatlabTaskPath, matlab);

