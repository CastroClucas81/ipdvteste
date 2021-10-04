<template>
  <div class="container">
    <div class="row">
      <div class="col-sm-6">
        <div class="card">
          <div class="card-body">
            <FormOffice />
          </div>
        </div>
      </div>
      <div class="col-sm-6">
        <div class="card">
          <div class="card-body">
            <ListOffices />
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import FormOffice from "@/components/FormOffice.vue";
import ListOffices from "@/components/ListOffices.vue";

export default {
  name: "Office",
  components: {
    FormOffice,
    ListOffices,
  },
};
</script>

<style scoped>
</style>