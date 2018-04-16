const { spawn } = require('child_process');
const fs = require('fs');
const util = require('util');

function runFile() {
  let response = '';
  let ls = spawn('clisp', ['-q','-i', `${__dirname}/../alpha-beta/alpha-beta.fas`, '-x', '(ALPHABETA)']);
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
