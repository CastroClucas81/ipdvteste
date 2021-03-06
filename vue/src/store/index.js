import Vue from "vue";
import Vuex from "vuex";

Vue.use(Vuex);

export default new Vuex.Store({
  state: {
    login: false,
  },
  mutations: {},
  actions: {
    login(status) {
      this.state.login = status;
    },
  },
  modules: {},
});
