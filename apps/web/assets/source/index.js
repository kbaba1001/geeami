// import worksCheck from "./worksCheck";
// worksCheck.print();

// http://stackoverflow.com/questions/42124812/component-rendered-as-comment-in-vuejs-jspm
// TODO vue-loader 入れないとダメっぽい
import Vue from 'vue/dist/vue.esm.js';

document.addEventListener('DOMContentLoaded', () => {
  const vm = new Vue({
    el: '#app1',
    render: function(createElement) {
      return createElement('div', {}, this.message);
    },
    data: {
      msg: 'Hello Vue!'
    }
  });

  console.log(vm)
})
