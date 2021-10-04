<template>
  <section>
    <notifications group="mensagem" width="500" />
    <transition-group mode="out-in">
      <form key="formImport">
        <h4>Importar usuários</h4>
        <div class="row">
          <div class="col-sm-9">
            <input
              class="form-control form-control-sm"
              type="file"
              ref="file"
            />
          </div>
          <div class="col-sm-3">
            <button
              class="btn btn-success btn-sm w-100"
              @click.prevent="importUsers"
            >
              importar
            </button>
          </div>
        </div>
        <small id="emailHelp" class="form-text text-muted"
          >Anexar arquivo .CSV com usuários.</small
        >
      </form>
      <div v-if="usersForDepartament" key="users">
        <h4 class="text-center">Usuários por departamento</h4>

        <table class="table">
          <thead>
            <tr>
              <th scope="col">Departamentos</th>
              <th scope="col">Usuários</th>
            </tr>
          </thead>
          <tbody
            v-for="(departamentUser, index) in usersForDepartament"
            :key="index"
          >
            <tr>
              <th scope="row">{{ departamentUser[0].description }}</th>
              <td>
                <ul>
                  <li
                    v-for="(user, i) in departamentUser"
                    :key="i"
                    class="mb-1"
                  >
                    <div class="row">
                      <div class="col-sm-6">
                        {{ user.name }}
                      </div>
                      <div class="col-sm-6">
                        <button
                          type="button"
                          class="btn btn-danger btn-circle"
                          @click.prevent="deleteUser(user.id)"
                        >
                          <i class="fa fa-trash-o" aria-hidden="true"></i>
                        </button>
                        <button
                          type="button"
                          class="btn btn-info btn-circle"
                          @click="showModal(user)"
                        >
                          <i
                            class="fa fa-pencil-square-o"
                            aria-hidden="true"
                          ></i>
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
          :data="usersForDepartament"
          @pagination-change-page="getResults"
        ></pagination>
        <Modal v-show="isModalVisible" @close="closeModal">
          <template v-slot:body>
            <input type="hidden" :value="idEdit" />
            <form>
              <h4 class="text-center">Editar Usuário</h4>

              <div class="mb-3">
                <label for="name" class="form-label">Nome</label>
                <input type="text" class="form-control" v-model="nameEdit" />
              </div>

              <div class="mb-3">
                <label for="email" class="form-label">E-mail</label>
                <input type="email" class="form-control" v-model="emailEdit" />
              </div>

              <div class="mb-3">
                <label for="password" class="form-label">Senha</label>
                <input
                  type="password"
                  class="form-control"
                  v-model="passwordEdit"
                />
              </div>

              <div class="mb-3">
                <label for="officeSelected" class="form-label">Cargo</label>
                <select class="form-select" v-model="officeSelectedEdit">
                  <option disabled>Selecione um cargo</option>
                  <option
                    v-for="office in offices"
                    :value="office.office_id"
                    :key="office.office_id"
                  >
                    {{ office.description }}
                  </option>
                </select>
              </div>

              <div class="mb-3">
                <label for="departamentSelected" class="form-label"
                  >Departamento</label
                >

                <select class="form-select" v-model="departamentSelectedIdEdit">
                  <option disabled>Selecione um Departamento</option>

                  <option
                    v-for="departament in departaments"
                    :value="departament.departament_id"
                    :key="departament.departament_id"
                  >
                    {{ departament.description }}
                  </option>
                </select>
              </div>

              <button class="btn btn-success" @click.prevent="submitEditUser">
                Submeter
              </button>
            </form>
          </template>
        </Modal>
      </div>
      <div v-else key="loading">
        <Loading />
      </div>
    </transition-group>
  </section>
</template>

<script>
import { api } from "@/services/services.js";
import Modal from "@/components/Modal.vue";

export default {
  name: "ListUserForDepartament",
  data() {
    return {
      idEdit: "",
      nameEdit: "",
      emailEdit: "",
      passwordEdit: "",
      officeSelectedEdit: "",
      departamentSelectedIdEdit: "",
      isModalVisible: false,
      file: "",
      offices: {},
      departaments: {},
      usersForDepartament: {},
    };
  },
  created() {
    this.$root.$refs.ListUserForDepartament = this;
    this.getOffice();
    this.getResults();
    this.getDepartament();
  },
  components: {
    Modal,
  },
  methods: {
    showModal(user) {
      this.idEdit = user.id;
      this.nameEdit = user.name;
      this.emailEdit = user.email;
      this.passwordEdit = user.password;
      this.officeSelectedEdit = user.office_idfk;
      this.departamentSelectedIdEdit = user.departament_idfk;
      this.isModalVisible = true;
    },
    closeModal() {
      this.isModalVisible = false;
    },
    submitEditUser() {
      const dataUser = {
        user_id: this.idEdit,
        name: this.nameEdit,
        email: this.emailEdit,
        password: this.passwordEdit,
        office_idfk: this.officeSelectedEdit,
        departament_idfk: this.departamentSelectedIdEdit,
      };

      api.post("user-edit", dataUser).then((response) => {
        this.$notify({
          group: "mensagem",
          title: "Mensagem importante",
          text: response.data,
        });
        this.getResults();
        this.closeModal();
      });
    },
    importUsers() {
      const file = this.$refs.file.files[0];

      if (file !== undefined) {
        const formData = new FormData();
        formData.append("file", file);

        if (file.name.slice(-3) === "csv" || file.name.slice(-3) === "CSV") {
          api.post("import-users", formData).then((response) => {
            this.$notify({
              group: "mensagem",
              title: "Mensagem importante",
              text: response.data,
            });
            this.$refs.file.value = "";
            this.getResults();
            this.closeModal();
          });
        } else {
          alert("Apenas arquivos com o formato .CSV são permitidos.");
        }
      } else {
        alert("Insira um arquivo.");
      }
    },
    deleteUser(id) {
      api.delete(`user-delete/${id}`).then((response) => {
        this.$notify({
          group: "mensagem",
          title: "Mensagem importante",
          text: response.data,
        });
        this.getResults();
      });
    },

    getOffice() {
      api.get("get-offices").then((response) => (this.offices = response.data));
    },
    getDepartament() {
      api.get("get-departaments").then((response) => {
        this.departaments = response.data;
      });
    },
    getResults(page = 1) {
      api
        .get(`all-user-for-departament/results?page=${page}`)
        .then((response) => {
          this.usersForDepartament = response.data;
        });
    },
  },
};
</script>

<style>
ul,
li {
  padding: 0px;
  list-style-type: none;
}

.btn-danger {
  margin-right: 10px;
}
</style>