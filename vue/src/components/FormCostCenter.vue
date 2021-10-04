<template>
  <form>
    <h4 class="text-center">Cadastrar Centro de Custo</h4>
    <notifications group="mensagem" width="500" />
    <div class="mb-3">
      <label for="office" class="form-label">Nome do centro de custo</label>
      <input
        type="text"
        class="form-control"
        id="office"
        v-model="costCenter"
        @change="$v.costCenter.$touch()"
      />
      <p v-if="$v.costCenter.$error" class="error-message">
        Este campo é requerido!
      </p>
    </div>

    <button class="btn btn-success" @click.prevent="submitCostCenter">
      Submeter
    </button>
  </form>
</template>

<script>
import { api } from "@/services/services.js";
import { required } from "vuelidate/lib/validators";

export default {
  name: "FormCostCenter",
  data() {
    return {
      costCenter: "",
    };
  },
  validations: {
    costCenter: { required },
  },
  methods: {
    submitCostCenter() {
      if (!this.$v.$invalid) {
        const newCostCenter = { description: this.costCenter };

        api.post("cost-center", newCostCenter).then((response) => {
          this.$root.$refs.ListCostsCenters.getResults();
          this.costCenter = "";
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

<style>
</style>