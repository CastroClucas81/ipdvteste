import Vue from 'vue'
import Vuelidate from 'vuelidate'
import App from './App.vue'
import router from './router'
import store from './store'
import Loading from '@/components/Loading.vue';
import Notifications from 'vue-notification'


Vue.config.productionTip = false
Vue.component("Loading", Loading)
Vue.component('pagination', require('laravel-vue-pagination'));
Vue.use(Vuelidate);
Vue.use(Notifications);

new Vue({
  router,
  store,
  render: h => h(App)
}).$mount('#app')
