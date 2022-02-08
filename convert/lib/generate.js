//generate the index.html main page
//and add a list to public/ folder for matlab to convert mlxs to htmls
//update lock file in convert/ folder

import * as fs from 'fs/promises';
import { existsSync } from 'fs';
import { resolve, relative, extname } from 'path';
import {EOL} from 'os';

/**scan folder for all mlx and ipynb */
async function scan(folder, projectDir) {
    const items = await fs.readdir(folder)
    const output = [];
    for (const d of items) {
        const item = resolve(folder, d);
        const s = await fs.stat(item);
        if (s.isDirectory() && !d.startsWith('.')) {
            output.push(...await scan(item,projectDir));
        }
        else if ((s.isFile() && !d.startsWith('_')) && (d.endsWith('mlx') || d.endsWith('ipynb'))) {
            const re = relative(projectDir, item)
            output.push(item);
        }
    }
    return output;
}

async function generate(projectDir, publicDir, shrinkPath, matlabTaskPath,templatePath) {
    //read the shrink file
    const text = existsSync(shrinkPath)
        ? await fs.readFile(shrinkPath, { encoding: 'utf-8' })
        : "";
    const formerShrink = text.split('\n').map(val => {
        const a = val.trim().split('\t');
        if (a.length >= 2) {
            const [num, path] = a;
            return { num: parseInt(num), path: path.trim() }
        }
    }).filter(val => val);
    let content = "";
    let shrink = [];
    let matlab = "";
    let count = formerShrink.reduce((pre, cur) => pre < cur.num ? cur.num : pre, 0);

    for (const f of await fs.readdir(projectDir)) {
        const folder = resolve(projectDir, f);
        const s = await fs.stat(folder);
        if (s.isDirectory() && /\d.*/.test(f)) {
            content += `\n<h2>${f.substring(0, 1)}<a name="${f.substring(1)}" href="#${f.substring(1)}">${f.substring(1)}</a></h2>\n`;
            const files = await scan(folder, projectDir);
            const iterms = []
            for (const file of files) {
                const ext = extname(file);
                const fileRel = relative(projectDir, file).replace(/\\/g, '/');
                const fileRelNoExt = file.replace(ext, '')
                let dst = ""
                //process mlx files to make a shrink file for matlab to convert
                if (ext == '.mlx') {
                    const s = formerShrink.find(val => val.path == fileRel);
                    const number = s ? s.num : ++count;
                    dst = 'm' + number + '.html'
                    shrink.push({ number, fileRel });
                    matlab += `${resolve(projectDir, file)}\t${resolve(publicDir, dst)}\n`
                }
                //process ipynb files to make a link to web
                else if (ext == '.ipynb') {
                    dst = `https://github.com/xsro/university-learning-code/tree/develop/${fileRel}`;
                };
                const findItermIdx = iterms.findIndex(
                    val => val.fileRelNoExt === fileRelNoExt
                )
                if (findItermIdx >= 0) {
                    iterms[findItermIdx].links.push({ ext, dst })
                } else {
                    iterms.push(
                        { fileRelNoExt, links: [{ ext, dst }] }
                    )
                }
            }
            const getNum = val => {
                const p = relative(folder, val);
                const s = p.match(/\d+/);
                return s ? parseInt(s[0]) : 200
            }
            const sortedIterms = iterms.sort((a, b) => getNum(a.fileRelNoExt) - getNum(b.fileRelNoExt))
            const contentText = sortedIterms.reduce(
                (pre, iterm) => {
                    const linksText = iterm.links.reduce(
                        (prelink, link) => prelink + `<a href=${link.dst}>${link.ext.replace('.', '')}</a>\n`, ""
                    )
                    const name = relative(folder, iterm.fileRelNoExt);
                    return pre + `<li>${name}: ${linksText}</li>`
                }, ""
            )
            content += '<ol>\n' + contentText + '</ol>';
        }
    }

    const html = await fs.readFile(templatePath, { encoding: 'utf-8' });

    await fs.writeFile(resolve(publicDir, 'index.html'),
        html.replace("<div id='content'> </div>", "<div id='content'>" + content + " </div>"));
    const compareShrink = function (a, b) {
        const res = a.number > b.number ? 1 : -1;
        return res
    }
    const shrinkText = shrink.sort(compareShrink).map(val => val.number + '\t' + val.fileRel).join(EOL)
    await fs.writeFile(shrinkPath, shrinkText);
    await fs.writeFile(matlabTaskPath, matlab);
}

export default generate;

