import Vue from 'vue';
import App from './App.vue'

// document.ready
document.addEventListener('DOMContentLoaded', () => {
  new Vue({
    el: '#app',
    render: h => h(App)
  });
});
