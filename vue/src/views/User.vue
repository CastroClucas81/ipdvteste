<template>
  <div class="row mb-4">
    <div class="col-sm-6">
      <div class="card">
        <div class="card-body">
          <UserForm />
        </div>
      </div>
    </div>
    <div class="col-sm-6">
      <div class="card">
        <div class="card-body">
          <ListUserForDepartament />
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import UserForm from "@/components/UserForm.vue";
import ListUserForDepartament from "@/components/ListUserForDepartament.vue";

export default {
  name: "User",
  components: {
    UserForm,
    ListUserForDepartament,
  },
};
</script>

<style scoped>
</style>