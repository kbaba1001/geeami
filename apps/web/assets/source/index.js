import Vue from 'vue';
import Vuetify from 'vuetify';

Vue.use(Vuetify);

import App from './App.vue';

// document.ready
document.addEventListener('DOMContentLoaded', () => {
  new Vue({
    el: '#app',
    render: h => h(App)
  });
});
