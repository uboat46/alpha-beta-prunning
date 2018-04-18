<template>
  <div class="hello">
    <!--<textarea name="" id="" cols="30" rows="10" v-model="board">

    </textarea>-->
    <table style="width:50%" v-if="board">
      <tr>
        <td >{{board[0]}}</td>
        <td v-for="i in 3" :key="i">{{board[i]}}</td>
      </tr>
      <tr>
        <td v-for="i in 7" :key="i" v-if="i > 3">{{board[i]}}</td>
      </tr>
      <tr>
        <td v-for="i in 11" :key="i" v-if="i > 7">{{board[i]}}</td>
      </tr>
      <tr>
        <td v-for="i in 15" :key="i" v-if="i > 11">{{board[i]}}</td>
      </tr>
      <tr>
        <td v-for="i in 19" :key="i" v-if="i > 15">{{board[i]}}</td>
      </tr>
      <tr>
        <td v-for="i in 23" :key="i" v-if="i > 19">{{board[i]}}</td>
      </tr>
      <tr>
        <td v-for="i in 27" :key="i" v-if="i > 23">{{board[i]}}</td>
      </tr>
      <tr>
        <td v-for="i in 31" :key="i" v-if="i > 27">{{board[i]}}</td>
      </tr>
    </table>
    <button @click="getBoard">JUEGA</button>
  </div>
</template>

<script>
import axios from 'axios'

export default {
  name: 'HelloWorld',
  data () {
    return {
      board: [1,1,1,1,
              1,1,1,1,
              1,1,1,1,
              0,0,0,0,
              0,0,0,0,
              2,2,2,2,
              2,2,2,2,
              2,2,2,2],
      fichas: []
    }
  },
  methods: {
    printBoard (data) {
      var vm = this;
      vm.fichas = []
      var res = data.data.trim();
      /*this.board = res;
      res = res.substring(1, res.length - 1).replace(/\n/g,'');
      res = res.split(') (');
      res.forEach(element => {
        var ficha = element.replace('(','').replace(')','').split(' ');
        if(ficha.length == 6){
          var ficha1 = [ficha[0], ficha[1], ficha[2]];
          var ficha2 = [ficha[3], ficha[4], ficha[5]];
          vm.fichas.push(ficha1);
          vm.fichas.push(ficha2);
        }
        vm.fichas.push(ficha);
      });*/
      alert(res);      
    },
    getBoard () {
      var board = '(';
      this.board.forEach((ficha, index) => {
        switch(ficha) {
          case 1:
            board += `(1 ${index} 3)`;
          break;
          case 0:
            board += `(NIL ${index} 0)`;
          break;
          case 2:
            board += `(2 ${index} 3)`;
          break;
        }
      }) 
      board += ')'
      this.callAPI(board);
    },
    callAPI (board) {
      var vm = this;
      axios.get(`http://localhost:3000?board=${board}`)
      .then(function (response) {
        vm.printBoard(response);
      })
      .catch(function (error) {
        console.log(error);
      });
    }
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
.hello{
  height: 100%;
  width: 100%;
}
.inputs{
  height: 30px;
  position: absolute;
  z-index: 100;
  top: 10%;
  left: 10%;
  background-color: white;
}
</style>
