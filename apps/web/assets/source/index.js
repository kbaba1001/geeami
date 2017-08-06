import Vue from 'vue';
import VueMaterial from 'vue-material'
import 'vue-material/dist/vue-material.css'
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
