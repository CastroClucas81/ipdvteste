<template>
  <form>
    <notifications group="mensagem" width="500" />
    <div class="mb-3">
      <label for="office" class="form-label">Nome Cargo</label>
      <input
        type="text"
        class="form-control"
        id="office"
        v-model="office"
        @change="$v.office.$touch()"
      />
      <p v-if="$v.office.$error" class="error-message">
        Este campo é requerido!
      </p>
    </div>

    <button class="btn btn-success" @click.prevent="submitOffice">
      Submeter
    </button>
  </form>
</template>

<script>
import { api } from "@/services/services.js";
import { required } from "vuelidate/lib/validators";

export default {
  name: "FormOffice",
  data() {
    return {
      office: "",
    };
  },
  validations: {
    office: { required },
  },
  props: {
    msg: String,
  },
  methods: {
    submitOffice() {
      if (!this.$v.$invalid) {
        const newOffice = { description: this.office };

        api.post("office", newOffice).then((response) => {
          this.$root.$refs.ListOffices.getResults();
          this.office = "";
          this.$notify({
            group: "mensagem",
            title: "Mensagem importante",
            text: response.data,
          });
        });
      } else {
        this.$v.$touch();
      }
    },
  },
};
</script>

<style scoped>
h3 {
  margin: 40px 0 0;
}
ul {
  list-style-type: none;
  padding: 0;
}
li {
  display: inline-block;
  margin: 0 10px;
}
a {
  color: #42b983;
}
</style>
