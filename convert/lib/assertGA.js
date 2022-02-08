//assert ga tag to htmls
import { readdirSync, statSync, readFileSync, writeFileSync } from "fs";
import { resolve } from "path";

const tag = `<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=G-B25JJR3WFM"></script>
<script>
window.dataLayer = window.dataLayer || [];
function gtag(){dataLayer.push(arguments);}
gtag('js', new Date());

gtag('config', 'G-B25JJR3WFM');
</script>`;

export default function (public_dir) {
  const files = readdirSync(public_dir);
  for (const file of files) {
    const filePath = resolve(public_dir, file);
    if (statSync(filePath).isFile()) {
      const text = readFileSync(filePath, { encoding: "utf-8" });
      const text1 = text.includes(
        "Global site tag (gtag.js) - Google Analytics"
      )
        ? text
        : text.replace("<head>", "<head>" + tag);
      writeFileSync(filePath, text1);
    }
  }
}
