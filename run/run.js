const { spawn } = require('child_process');
const fs = require('fs');
const util = require('util');

function runFile() {
  let response = '';
  let s = `'( (1 0 3) (1 1 3) (1 2 3) (1 3 3) 
              (1 4 3) (1 5 3) (1 6 3) (1 7 3)
              (1 8 3) (1 9 3) (1 10 3) (1 11 3)
              (NIL 12 3) (NIL 13 3) (NIL 14 3) (NIL 15 3)
              (2 16 3) (NIL 17 3) (NIL 18 3) (NIL 19 3)
              (NIL 20 3) (2 21 3) (2 22 3) (2 23 3)
              (2 24 3) (2 25 3) (2 26 3) (2 27 3)
              (2 28 3) (2 29 3) (2 30 3) (2 31 3)   )`;
              //PUEDEMOVER ${s} 8 1 3 
  let ls = spawn('clisp', ['-q','-i', `${__dirname}/../alpha-beta/alpha-beta.fas`, '-x', `(JUEGA ${s} 1 3)`]);
  ls.stdout.on('data', (data) => {
    console.log(`stdout: ${data}`);
  });
  
  ls.stderr.on('data', (data) => {
   console.log(`stderr: ${data}`);
   //ls.kill();
  });
  
  ls.on('close', (code) => {
    ls.kill();
    console.log(`child process exited with code ${code}`);
  });

}

function run() {
    runFile();
    //res.status(200).send('Please send arguments to run\n    ex. \n    node run.js rennes avignon');
}

module.exports = run;
