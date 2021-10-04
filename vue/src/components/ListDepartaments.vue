<template>
  <section>
    <div v-if="departaments" key="departaments">
      <h4 class="text-center">Lista de Departamentos</h4>
      <table class="table">
        <thead>
          <tr>
            <th scope="col">Centro de Custo</th>
            <th scope="col">Departamentos</th>
          </tr>
        </thead>
        <tbody v-for="(departament, index) in departaments" :key="index">
          <tr>
            <th scope="row">{{ departament[0].cost_center_description }}</th>
            <td>
              <ul>
                <li v-for="(depart, i) in departament" :key="i" class="mb-1">
                  <div class="row">
                    <div class="col-sm-6">
                      {{ depart.description }}
                    </div>
                    <div class="col-sm-6">
                      <button
                        type="button"
                        class="btn btn-danger btn-circle"
                        @click.prevent="deleteDepartament(depart.departament_id)"
                      >
                        <i class="fa fa-trash-o" aria-hidden="true"></i>
                      </button>
                      <button
                        type="button"
                        class="btn btn-info btn-circle"
                        @click="showModal(depart)"
                      >
                        <i class="fa fa-pencil-square-o" aria-hidden="true"></i>
                      </button>
                    </div>
                  </div>
                </li>
              </ul>
            </td>
          </tr>
        </tbody>
      </table>
      <pagination
        :data="departaments"
        @pagination-change-page="getResults"
      ></pagination>
      <Modal v-show="isModalVisible" @close="closeModal">
        <template v-slot:body>
          <h4 class="text-center">Editar Departamento</h4>
          <notifications group="mensagem" width="500" />
          <form>
            <input type="hidden" :value="idEdit" />
            <div class="mb-3">
              <label for="departament" class="form-label">Departamento</label>
              <input
                type="text"
                class="form-control"
                id="departament"
                v-model="descriptionEdit"
              />
            </div>

            <div class="mb-3">
              <label for="costCenterSelect" class="form-label"
                >Centro de custo</label
              >
              <select
                id="costCenterSelect"
                class="form-select"
                v-model="costCenterEdit"
              >
                <option>Selecione um centro de custo</option>
                <option
                  v-for="costcenter in costCenters"
                  :value="costcenter.cost_center_id"
                  :key="costcenter.cost_center_id"
                >
                  {{ costcenter.description }}
                </option>
              </select>
            </div>

            <button
              class="btn btn-success"
              @click.prevent="submitEditDepartament"
            >
              Submeter
            </button>
          </form>
        </template>
      </Modal>
    </div>
    <div v-else key="loading">
      <Loading />
    </div>
  </section>
</template>

<script>
import { api } from "@/services/services.js";
import Modal from "@/components/Modal.vue";

export default {
  name: "ListDepartaments",
  data() {
    return {
      departaments: {},
      isModalVisible: false,
      descriptionEdit: "",
      costCenterEdit: "",
      idEdit: "",
      costCenters: {},
    };
  },
  components: {
    Modal,
  },
  created() {
    this.$root.$refs.ListDepartaments = this;
    this.getResults();
  },
  methods: {
    showModal(office) {
      this.getCostCenters();
      this.descriptionEdit = office.description;
      this.idEdit = office.departament_id;
      this.costCenterEdit = office.cost_center_idfk;
      this.isModalVisible = true;
    },
    closeModal() {
      this.isModalVisible = false;
    },
    submitEditDepartament() {
      const dataDepartament = {
        departament_id: this.idEdit,
        cost_center_idfk: this.costCenterEdit,
        description: this.descriptionEdit,
      };

      api.post("departament-edit", dataDepartament).then((response) => {
        this.$notify({
          group: "mensagem",
          title: "Mensagem importante",
          text: response.data,
        });
        this.getResults();
        this.closeModal();
      });
    },
    deleteDepartament(id) {
      api.delete(`departament-delete/${id}`).then((response) => {
        this.$notify({
          group: "mensagem",
          title: "Mensagem importante",
          text: response.data,
        });
        this.getResults();
      });
    },
    getCostCenters() {
      api.get("get-cost-center").then((response) => {
        this.costCenters = response.data;
      });
    },
    getResults(page = 1) {
      api.get(`all_departaments/results?page=${page}`).then((response) => {
        this.departaments = response.data;
      });
    },
  },
};
</script>

<style scoped>
.btn-danger {
  margin-right: 10px;
}
</style>