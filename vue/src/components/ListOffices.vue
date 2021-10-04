<template>
  <section>
    <transition mode="out-in">
      <div v-if="offices" key="offices">
        <h4 class="text-center">Lista de Cargos</h4>
        <table class="table">
          <thead>
            <tr>
              <th scope="col">#</th>
              <th scope="col">Cargo</th>
              <th scope="col"></th>
            </tr>
          </thead>
          <tbody v-for="office in offices.data" :key="office.office_id">
            <tr>
              <th scope="row" width="40">{{ office.office_id }}</th>
              <th scope="row">{{ office.description }}</th>
              <th scope="col" width="100">
                <button
                  type="button"
                  class="btn btn-danger btn-circle"
                  @click.prevent="deleteOffice(office.office_id)"
                >
                  <i class="fa fa-trash-o" aria-hidden="true"></i>
                </button>
                <button
                  type="button"
                  class="btn btn-info btn-circle"
                  @click="showModal(office)"
                >
                  <i class="fa fa-pencil-square-o" aria-hidden="true"></i>
                </button>
              </th>
            </tr>
          </tbody>
        </table>
        <pagination
          :data="offices"
          @pagination-change-page="getResults"
        ></pagination>
        <Modal v-show="isModalVisible" @close="closeModal">
          <template v-slot:body>
            <h4 class="text-center">Editar Cargo</h4>
            <notifications group="mensagem" width="500" />
            <form>
              <input type="hidden" :value="idEdit" />
              <div class="mb-3">
                <label for="office" class="form-label">Nome Cargo</label>
                <input
                  type="text"
                  class="form-control"
                  id="office"
                  v-model="descriptionEdit"
                />
              </div>

              <button class="btn btn-success" @click.prevent="submitEditOffice">
                Editar
              </button>
            </form>
          </template>
        </Modal>
      </div>
      <div v-else key="loading">
        <Loading />
      </div>
    </transition>
  </section>
</template>

<script>
import { api } from "@/services/services.js";
import Modal from "@/components/Modal.vue";

export default {
  name: "ListOffices",
  data() {
    return {
      offices: {},
      isModalVisible: false,
      descriptionEdit: "",
      idEdit: "",
    };
  },
  components: {
    Modal,
  },
  created() {
    this.$root.$refs.ListOffices = this;
    this.getResults();
  },
  methods: {
    showModal(office) {
      this.descriptionEdit = office.description;
      this.idEdit = office.office_id;
      this.isModalVisible = true;
    },
    closeModal() {
      this.isModalVisible = false;
    },
    submitEditOffice() {
      const dataOffice = {
        office_id: this.idEdit,
        description: this.descriptionEdit,
      };

      api.post("office-edit", dataOffice).then((response) => {
        this.$notify({
          group: "mensagem",
          title: "Mensagem importante",
          text: response.data,
        });
        this.getResults();
        this.closeModal();
      });
    },
    deleteOffice(id) {
      api.delete(`office-delete/${id}`).then((response) => {
        this.$notify({
          group: "mensagem",
          title: "Mensagem importante",
          text: response.data,
        });
        this.getResults();
      });
    },
    getResults(page = 1) {
      api.get(`all_offices/results?page=${page}`).then((response) => {
        this.offices = response.data;
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