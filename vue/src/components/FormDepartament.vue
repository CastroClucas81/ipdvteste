<template>
  <form>
    <h4 class="text-center">Cadastrar Departamento</h4>
    <notifications group="mensagem" width="500" />
    <div class="mb-3">
      <label for="departament" class="form-label">Departamento</label>
      <input
        type="text"
        class="form-control"
        id="departament"
        v-model="departament"
      />
      <p v-if="$v.departament.$error" class="error-message">
        Este campo é requerido!
      </p>
    </div>

    <div class="mb-3">
      <label for="costCenterSelect" class="form-label">Centro de custo</label>
      <select
        id="costCenterSelect"
        class="form-select"
        v-model="costCenterSelected"
      >
        <option disabled>Selecione um centro de custo</option>
        <option
          v-for="costcenter in costCenters"
          :value="costcenter.cost_center_id"
          :key="costcenter.cost_center_id"
        >
          {{ costcenter.description }}
        </option>
      </select>
      <p v-if="$v.costCenterSelected.$error" class="error-message">
        Este campo é requerido!
      </p>
    </div>

    <button class="btn btn-success" @click.prevent="submitDepartament">
      Submeter
    </button>
  </form>
</template>

<script>
import { api } from "@/services/services.js";
import { required } from "vuelidate/lib/validators";

export default {
  name: "FormDepartament",
  data() {
    return {
      departament: "",
      costCenterSelected: "",
      costCenters: {},
    };
  },
  validations: {
    departament: { required },
    costCenterSelected: { required },
  },
  created() {
    this.getCostCenters();
  },
  methods: {
    submitDepartament() {
       if (!this.$v.$invalid) {
        const newDepartament = {
          cost_center_idfk: this.costCenterSelected,
          description: this.departament,
        };

        api.post("departament", newDepartament).then((response) => {
           this.$root.$refs.ListDepartaments.getResults();
          this.departament = "";
          this.costCenterSelected = "";
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
    getCostCenters() {
      api.get("get-cost-center").then((response) => {
        this.costCenters = response.data;
      });
    },
  },
};
</script>

<style>
</style>