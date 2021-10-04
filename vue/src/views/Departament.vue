<template>
  <div class="container">
    <div class="row">
      <div class="col-sm-6">
        <div class="card">
          <div class="card-body">
            <FormDepartament />
          </div>
        </div>
      </div>
      <div class="col-sm-6">
        <div class="card">
          <div class="card-body">
            <ListDepartaments />
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import FormDepartament from "@/components/FormDepartament.vue";
import ListDepartaments from "@/components/ListDepartaments.vue";

export default {
  name: "Departament",
  components: {
    FormDepartament,
    ListDepartaments,
  },
};
</script>

<style>
</style>