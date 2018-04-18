<template>
  <div id="app">
    <router-view :filas="filas" @mov="changeTablero"/>
  </div>
</template>

<script>
export default {
  name: 'App',
  data () {
    return {
      filas: [
        [1,1,1,1],
        [1,1,1,1],
        [1,1,1,1],
        [0,0,0,0],
        [0,0,0,0],
        [2,2,2,2],
        [2,2,2,2],
        [2,2,2,2],
        [2,2,2,2]
      ]
    }
  },
  methods : {
    changeTablero (board) {
      this.filas = board;
    }
  }
}
</script>

<style>
html{
  height: 100%;
  width: 100%;
}
body{
  height: 100%;
  width: 100%;
  margin: 0;
}
#app {
  height: 100%;
  width: 100%;
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
}
</style>
