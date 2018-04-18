<template>
  <div class="hello">
    <!--<textarea name="" id="" cols="30" rows="10" v-model="board">

    </textarea>-->
    <table style="width:70%;margin:auto;height:80%;">
      <tr v-for="(fila, i) in filas" :key="i">
        <template v-for="(ficha, f) in fila">
          <td v-if="(i % 2) == 1" :key="f+100" class="grey"></td>
          <td 
          :key="f"
          @click="selectFrom($event, i, f)" 
          :class="{black: (ficha == 1), red: (ficha == 2), nil: (ficha == 0), selected: ((i == selected.fila) && (f == selected.col))}"
          :id="`${i}-${f}`">{{ficha}}</td>
          <td v-if="(i % 2) == 0" :key="f+400" class="grey"></td>
        </template>
      </tr>
      
    </table>

    <button @click="getBoard">JUEGA</button>
  </div>
</template>

<script>
import axios from 'axios'

export default {
  name: 'HelloWorld',
  props: ['filas'],
  data () {
    return {
      fichas: [],
      selected: {
        col: -1,
        fila: -1
      }
    }
  },
  methods: {
    pinta (){
      var vm = this;
      this.filas.forEach((fila, i) => {
        fila.forEach((ficha, index) => {
          var ele = document.getElementById(`${i}-${index}`);
          ele.innerHTML = ficha;
          switch(ficha) {
            case 1:
              ele.classList = '';
              ele.classList.add('black');
            break;
            case 0:
              ele.classList = '';
              ele.classList.add('nil');
            break;
            case 2:
              ele.classList = '';
              ele.classList.add('red');
            break;
          }
        });
      });
    },
    selectFrom (e, fila, col){
      var vm = this;
      if(vm.filas[fila][col] == 2){
        vm.selected.fila = fila;
        vm.selected.col = col;
      }else {
        if(vm.selected.fila != -1){
          if(Math.abs(fila - vm.selected.fila) > 1 ){
            if((vm.selected.fila - fila) > 0){
              if((vm.selected.col - col) > 0){
                vm.comeA(fila + 1, col + 1);
              }else {
                vm.comeA(fila + 1, col - 1);
              }
            }else {
              if((vm.selected.col - col) > 0){
                vm.comeA(fila - 1, col + 1);
              }else {
                vm.comeA(fila - 1, col - 1);
              }
            }
          }
          vm.mueveA(fila, col);
        }
      }
    },
    mueveA (fila, col){
      var vm = this;
      var old = vm.filas[vm.selected.fila][vm.selected.col];
      vm.filas[vm.selected.fila][vm.selected.col] = vm.filas[fila][col];
      vm.filas[fila][col] = old; 
      vm.pinta();
      vm.getBoard();
    },
    comeA (fila, col){
      var vm = this;
      console.log(fila,col);
      vm.filas[fila][col] = 0;
      vm.pinta();
    },
    mueve (pos, mov) {
      var vm = this;
      var pos = parseInt(pos);
      var npos = parseInt(pos) + parseInt(mov);
      var fila = Math.floor(pos / 4);
      var nfila = Math.floor(npos / 4);
      var old = vm.filas[fila][pos % 4];
      vm.filas[fila][pos % 4] = vm.filas[nfila][npos % 4];
      vm.filas[nfila][npos % 4] = old; 
      console.log(this.filas);
      vm.pinta();
    },
    come (pos, come) {
      var vm = this;
      var npos = parseInt(pos) + parseInt(come);
      var nfila = Math.floor(npos / 4);
      vm.filas[nfila][npos % 4] = 0; 
      vm.pinta();
    },
    printBoard (data) {
      var vm = this;
      vm.fichas = []
      var res = data.data.trim();
      console.log(res);
      var pos = res.substring(res.indexOf('NIL') + 5 ,res.indexOf('NIL') + 8).replace(')','').trim();
      var mov = res.substring(res.indexOf('NIL') + 7 ,res.indexOf('NIL') + 10).replace(')','').trim();
      var come = res.substring(res.indexOf('NIL') + 10 ,res.indexOf('NIL') + 13).replace(')','').replace(')','').trim();
      this.mueve(pos, mov);  
      if(come != ''){
        this.come(pos, come);
      }   
    },
    getBoard () {
      var req = '(';
      this.filas.forEach((fila, i) => {
        fila.forEach((ficha, index) => {
          switch(ficha) {
            case 1:
              req += `(1 ${(4*i) + index} 3)`;
            break;
            case 0:
              req += `(NIL ${(4*i) + index} 0)`;
            break;
            case 2:
              req += `(2 ${(4*i) + index} 3)`;
            break;
          }
        });
      });
      req += ')';
      this.callAPI(req);
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
.black { 
  background-color: black;
  color: white;
}
.red{ 
  background-color: rgb(158, 22, 22);
  color: white;
}
.nil {
  background-color: rgb(206, 175, 4);
  color: black;
}
.grey {
  background-color: rgb(253, 232, 232);
  color: black;
}
.selected {
  background-color: yellow;
  color: black;
}
</style>
