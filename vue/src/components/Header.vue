<template>
  <header
    class="
      d-flex
      flex-wrap
      align-items-center
      justify-content-center justify-content-md-between
      py-3
      mb-4
      border-bottom
    "
  >
    <a
      href="/"
      class="
        d-flex
        align-items-center
        col-md-3
        mb-2 mb-md-0
        text-dark text-decoration-none
      "
    >
      <svg
        class="bi me-2"
        width="40"
        height="32"
        role="img"
        aria-label="Bootstrap"
      >
        <use xlink:href="#bootstrap" />
      </svg>
    </a>

    <ul class="nav col-12 col-md-auto mb-2 justify-content-center mb-md-0">
      <li>
        <router-link class="nav-link" to="/cost-center"
          >Centro de custo</router-link
        >
      </li>
      <li>
        <router-link class="nav-link" to="/departament"
          >Departamento</router-link
        >
      </li>
      <li><router-link class="nav-link" to="/office">Cargo</router-link></li>
      <li><router-link class="nav-link" to="/user">Usuário</router-link></li>
    </ul>

    <div class="col-md-3 text-end">
      <button
        v-if="statusLogin"
        class="btn btn-outline-success me-2"
        @click.prevent="logout"
      >
        Logout
      </button>
      <router-link v-else class="btn btn-outline-success me-2" to="/"
        >Sign in</router-link
      >
    </div>
  </header>
</template>

<script>
import Cookie from "js-cookie";

export default {
  name: "Header",
  computed: {
    statusLogin() {
      return this.$store.state.login;
    },
  },
  methods: {
    logout() {
      Cookie.remove("token");
      this.$store.dispatch("login", false);
      this.$router.push({ name: "Login" });
    },
  },
};
</script>

<style scoped>
header {
  padding: 30px;
}

header a {
  font-weight: bold;
  color: #2c3e50;
}

header a.router-link-exact-active {
  color: #42b983;
}
</style>