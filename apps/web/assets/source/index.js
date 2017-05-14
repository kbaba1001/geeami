// import worksCheck from "./worksCheck";
// worksCheck.print();

// http://stackoverflow.com/questions/42124812/component-rendered-as-comment-in-vuejs-jspm
import Vue from 'vue';
import App from './App.vue'

new Vue({
  el: '#app',
  render: h => h(App)
})


// document.addEventListener('DOMContentLoaded', () => {
//   const vm = new Vue({
//     el: '#app1',
//     render: function(createElement) {
//       return createElement('div', {}, this.message);
//     },
//     data: {
//       message: 'Hello Vue!'
//     }
//   });
//
//   console.log(vm)
// })
