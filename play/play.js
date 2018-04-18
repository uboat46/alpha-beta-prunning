const { spawn } = require('child_process');
const fs = require('fs');
const util = require('util');

function runFile(board, res) {
  let args = `(JUEGA '${board} 1 5)`;
  let response = '';
  let ls = spawn('clisp', ['-q','-i', `${__dirname}/../alpha-beta/alpha-beta.fas`, '-x', `(JUEGA '${board} 1 3)`]);
  
  ls.stdout.on('data', (data) => {
    response += data;
    console.log(`stdout: ${data}`);
  });
  
  ls.stderr.on('data', (data) => {
   console.log(`stderr: ${data}`);
   //ls.kill();
  });
  
  ls.on('close', (code) => {
    response = `${response}`.replace("\n","").replace(";; Loading file /Users/emilianosotomayor/Documents/ITAM/sexto/ai/alpha-beta-prunning/alpha-beta/alpha-beta.fas ...;; Loaded file /Users/emilianosotomayor/Documents/ITAM/sexto/ai/alpha-beta-prunning/alpha-beta/alpha-beta.fas","");
    response = response.replace('\n','');
    ls.kill();
    res.status(200).send(response);
    console.log(`child process exited with code ${code}`);
  });

}

function play(board, res) {
  if(board.trim() != "")
  {
    runFile(board, res);
  }else {
    res.status(200).send('Please send arguments to run\n    ex. \n    node run.js "(epic board)"');
  }
}

module.exports = play;