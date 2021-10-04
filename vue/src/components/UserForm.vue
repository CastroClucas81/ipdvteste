<template>
  <form>
    <h4 class="text-center">Cadastrar Usuário</h4>
    <notifications group="mensagem" width="500" />
    <div class="mb-3">
      <label for="name" class="form-label">Nome</label>
      <input type="text" class="form-control" id="name" v-model="name" />
      <p v-if="$v.name.$error" class="error-message">Este campo é requerido!</p>
    </div>

    <div class="mb-3">
      <label for="email" class="form-label">E-mail</label>
      <input type="email" class="form-control" id="email" v-model="email" />
      <p v-if="$v.email.$error" class="error-message">
        Este campo é requerido!
      </p>
    </div>

    <div class="mb-3">
      <label for="password" class="form-label">Senha</label>
      <input
        type="password"
        class="form-control"
        id="password"
        v-model="password"
      />
      <p v-if="$v.password.$error" class="error-message">
        Este campo é requerido!
      </p>
    </div>

    <div class="mb-3">
      <label for="officeSelected" class="form-label">Cargo</label>
      <select id="officeSelected" class="form-select" v-model="officeSelected">
        <option disabled>Selecione um cargo</option>
        <option
          v-for="office in offices"
          :value="office.office_id"
          :key="office.office_id"
        >
          {{ office.description }}
        </option>
      </select>
      <p v-if="$v.officeSelected.$error" class="error-message">
        Este campo é requerido!
      </p>
    </div>

    <div class="mb-3">
      <label for="departamentSelected" class="form-label">Departamento</label>
      <select
        id="departamentSelected"
        class="form-select"
        v-model="departamentSelected"
      >
        <option disabled>Selecione um Departamento</option>

        <option
          v-for="departament in departaments"
          :value="departament.departament_id"
          :key="departament.departament_id"
        >
          {{ departament.description }}
        </option>
      </select>
      <p v-if="$v.departamentSelected.$error" class="error-message">
        Este campo é requerido!
      </p>
    </div>

    <button class="btn btn-success" @click.prevent="submitUser">
      Submeter
    </button>
  </form>
</template>

<script>
import { api } from "@/services/services.js";
import { required, email } from "vuelidate/lib/validators";

export default {
  name: "UserForm",
  data() {
    return {
      name: "",
      email: "",
      password: "",
      officeSelected: "",
      departamentSelected: "",
      offices: {},
      departaments: {},
    };
  },
  validations: {
    name: { required },
    email: { required, email },
    password: { required },
    officeSelected: { required },
    departamentSelected: { required },
  },
  created() {
    this.getOffice();
    this.getDepartament();
  },
  methods: {
    getOffice() {
      api.get("get-offices").then((response) => (this.offices = response.data));
    },
    getDepartament() {
      api.get("get-departaments").then((response) => {
        this.departaments = response.data;
      });
    },
    submitUser() {
      if (!this.$v.$invalid) {
        if (this.name) {
          const newUser = {
            name: this.name,
            email: this.email,
            password: this.password,
            office_idfk: this.officeSelected,
            departament_idfk: this.departamentSelected,
          };

          api.post("user", newUser).then((response) => {
            this.$root.$refs.ListUserForDepartament.getResults();
            this.$notify({
              group: "mensagem",
              title: "Mensagem importante",
              text: response.data,
            });
            this.name = "";
            this.email = "";
            this.password = "";
            this.officeSelected = "";
            this.departamentSelected = "";
          });
        }
      } else {
        this.$v.$touch();
      }
    },
  },
};
</script>

<style>
</style>