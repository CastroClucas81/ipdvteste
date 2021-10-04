<template>
  <section>
    <transition>
      <div v-if="costsCenters" key="resultados">
        <h4 class="text-center">Lista dos Centros de Custos</h4>
        <table class="table">
          <thead>
            <tr>
              <th scope="col">#</th>
              <th scope="col">Centro de Custo</th>
              <th scope="col"></th>
            </tr>
          </thead>
          <tbody
            v-for="costCenter in costsCenters.data"
            :key="costCenter.cost_center_id"
          >
            <tr>
              <th scope="row">{{ costCenter.cost_center_id }}</th>
              <td scope="row">{{ costCenter.description }}</td>
              <th scope="col" width="100">
                <button
                  type="button"
                  class="btn btn-danger btn-circle"
                  @click.prevent="deleteCostCenter(costCenter.cost_center_id)"
                >
                  <i class="fa fa-trash-o" aria-hidden="true"></i>
                </button>
                <button
                  type="button"
                  class="btn btn-info btn-circle"
                  @click="showModal(costCenter)"
                >
                  <i class="fa fa-pencil-square-o" aria-hidden="true"></i>
                </button>
              </th>
            </tr>
          </tbody>
        </table>
        <pagination
          :data="costsCenters"
          @pagination-change-page="getResults"
        ></pagination>
      </div>
      <div key="loading" v-else>
        <Loading />
      </div>
    </transition>

    <Modal v-show="isModalVisible" @close="closeModal">
      <template v-slot:body>
        <h4 class="text-center">Editar Centro de Custo</h4>
        <notifications group="mensagem" width="500" />
        <form>
          <input type="hidden" :value="idEdit" />
          <div class="mb-3">
            <label for="office" class="form-label"
              >Nome do centro de custo</label
            >
            <input
              type="text"
              class="form-control"
              id="office"
              v-model="descriptionEdit"
            />
          </div>

          <button class="btn btn-success" @click.prevent="submitEditCostCenter">
            Submeter
          </button>
        </form>
      </template>
    </Modal>
  </section>
</template>

<script>
import { api } from "@/services/services.js";
import Modal from "@/components/Modal.vue";

export default {
  name: "ListCostsCenters",
  data() {
    return {
      costsCenters: {},
      isModalVisible: false,
      descriptionEdit: "",
      idEdit: "",
    };
  },
  created() {
    this.$root.$refs.ListCostsCenters = this;
    this.getResults();
  },
  components: {
    Modal,
  },
  methods: {
    showModal(costCenter) {
      this.descriptionEdit = costCenter.description;
      this.idEdit = costCenter.cost_center_id;
      this.isModalVisible = true;
    },
    closeModal() {
      this.isModalVisible = false;
    },
    submitEditCostCenter() {
      const dataCostCenter = {
        cost_center_id: this.idEdit,
        description: this.descriptionEdit,
      };

      api.post("cost-center-edit", dataCostCenter).then((response) => {
        this.$notify({
          group: "mensagem",
          title: "Mensagem importante",
          text: response.data,
        });
        this.getResults();
        this.closeModal();
      });
    },
    deleteCostCenter(id) {
      api.delete(`cost-center-delete/${id}`).then((response) => {
        this.$notify({
          group: "mensagem",
          title: "Mensagem importante",
          text: response.data,
        });

        this.getResults();
      });
    },
    getResults(page = 1) {
      api.get(`all_cost_centers/results?page=${page}`).then((response) => {
        this.costsCenters = response.data;
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