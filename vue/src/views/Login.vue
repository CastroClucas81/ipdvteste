<template>
  <main class="form-signin">
     <notifications group="mensagem" width="500" />
    <form>
      <h1 class="h3 mb-3 fw-normal">Faça o Login</h1>
      <div class="form-floating">
        <input
          v-model="email"
          type="email"
          class="form-control"
          id="floatingInput"
          placeholder="name@example.com"
          @change="$v.email.$touch()"
        />
        <label for="floatingInput">E-mail</label>
      </div>
      <p v-if="$v.email.$error" class="error-message">
        Este campo é requerido!
      </p>
      <div class="form-floating">
        <input
          v-model="password"
          type="password"
          class="form-control"
          id="floatingPassword"
          placeholder="Password"
          @change="$v.password.$touch()"
        />
        <label for="floatingPassword">Senha</label>
      </div>
      <p v-if="$v.password.$error" class="error-message">
        Este campo é requerido!
      </p>

      <button class="w-100 btn btn-lg btn-success" @click.prevent="submit">
        Entrar
      </button>
    </form>
  </main>
</template>

<script>
import Cookie from "js-cookie";
import { required } from "vuelidate/lib/validators";

export default {
  name: "Login",
  data() {
    return {
      email: "",
      password: "",
    };
  },
  validations: {
    email: { required },
    password: { required },
  },
  methods: {
    submit() {
      if (!this.$v.$invalid) {
        const payload = {
          email: this.email,
          password: this.password,
        };
        fetch("http://localhost:8000/api/login", {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
            Access: "application/json",
          },
          body: JSON.stringify(payload),
        })
          .then((response) => response.json())
          .then((res) => {
            if (res.access_token) {
              Cookie.set("token", res.access_token);
              this.$store.dispatch("login", true);
              this.$router.push({ name: "Dashboard" });
              
            } else {
              this.$notify({
                group: "mensagem",
                title: "Mensagem importante",
                text: "Esta conta não está cadastrada",
              });
            }
          });
      } else {
        this.$v.$touch();
      }
    },
  },
};
</script>

<style scoped>
.form-signin {
  width: 100%;
  max-width: 330px;
  padding: 15px;
  margin: auto;
}

.form-signin .checkbox {
  font-weight: 400;
}

.form-signin .form-floating:focus-within {
  z-index: 2;
}

.form-signin input[type="email"] {
  margin-bottom: -1px;
  border-bottom-right-radius: 0;
  border-bottom-left-radius: 0;
}

.form-signin input[type="password"] {
  margin-bottom: 10px;
  border-top-left-radius: 0;
  border-top-right-radius: 0;
}
</style>