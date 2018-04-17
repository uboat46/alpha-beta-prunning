const { spawn } = require('child_process');
const fs = require('fs');
const util = require('util');

function runFile() {
  let response = '';
  let s = `'( (1 0 3) (1 1 3) (1 2 3) (1 3 3) 
              (1 4 3) (1 5 3) (1 6 3) (1 7 3)
              (1 8 3) (1 9 3) (1 10 3) (1 11 3)
              (NIL 12 3) (NIL 13 3) (NIL 14 3) (NIL 15 3)
              (NIL 16 3) (NIL 17 3) (NIL 18 3) (NIL 19 3)
              (2 20 3) (2 21 3) (2 22 3) (2 23 3)
              (2 24 3) (2 25 3) (2 26 3) (2 27 3)
              (2 28 3) (2 29 3) (2 30 3) (2 31 3)   )`;
  let ls = spawn('clisp', ['-q','-i', `${__dirname}/../alpha-beta/alpha-beta.fas`, '-x', `(PUEDEMOVER ${s} 9 1 3 )`]);
  //res.status(200).send(`${__dirname}/aStar/ASTAR.fas`);
  //let ls = spawn('clisp', ['-q','-i', `/root/mapTraversalClisp/aStar/ASTAR.fas`, '-x', `(look '${start} '${end})`], {shell: 'bin/bash'});
  //let ls = spawn('/bin/bash', ['/root/mapTraversalClisp/look.sh', '\''+start, '\''+end]);
  //let ls = spawn('clisp', ['-q', '-x', '(PRINT \'hello']);
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
