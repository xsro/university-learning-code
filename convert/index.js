import * as ghpages from "gh-pages";
import assertGA from "./lib/assertGA.js";
import generate from "./lib/generate.js";
import { resolve, dirname } from "path";
import * as fs from "fs";
import { execSync } from "child_process";

const s = fs.statSync(process.argv[1]);
const _dirname = s.isDirectory() ? process.argv[1] : dirname(process.argv[1]);
const projectDir = resolve(_dirname, "..");
const publicDir = resolve(_dirname, "public");

if (!fs.existsSync(publicDir)) {
  fs.mkdirSync(publicDir);
}

if (process.argv.includes("gen")) {
  const shrinkPath = resolve(_dirname, "mlx2html-lock.txt");
  const taskPath = resolve(_dirname, "public", "matlab_task.txt");
  const templatePath = resolve(_dirname, "lib", "index.html");
  generate(projectDir, publicDir, shrinkPath, taskPath, templatePath);
}

if (process.argv.includes("ga")) {
  assertGA(publicDir);
}

if (process.argv.includes("deploy")) {
  try {
    execSync("yarn prettier --write .", { cwd: publicDir });
  } catch (e) {
    console.log(e);
  }

  ghpages.publish(
    publicDir,
    {
      src: "**/*.html",
      //   history: false,
      message:
        "update " + execSync("git rev-parse HEAD", { encoding: "utf-8" }),
    },
    (err) => {
      if (err) {
        console.error(err);
      } else {
        console.log("published");
      }
    }
  );
}
