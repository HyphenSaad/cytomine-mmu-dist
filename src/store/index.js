import Vue from 'vue';
import Vuex from 'vuex';
import currentUser from './modules/currentUser';
import projects from './modules/projects';

Vue.use(Vuex);

export default new Vuex.Store({
  modules: {
    currentUser,
    projects
  },
  actions: {
    async logout({ commit, dispatch }) {
      // Reset all modules that might contain user data
      commit('currentUser/resetState');

      // Clear other modules as needed
      commit('projects/resetState', null, { root: true });

      // Clear localStorage items if any
      localStorage.removeItem('authToken');
      localStorage.removeItem('userSession');

      // Any other cleanup needed
    }
  }
});