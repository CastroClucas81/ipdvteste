<template>
  <div class="container">
    <div class="row">
      <div class="col-sm-6">
        <div class="card">
          <div class="card-body">
            <FormCostCenter />
          </div>
        </div>
      </div>
      <div class="col-sm-6">
        <div class="card">
          <div class="card-body">
            <ListCostsCenters />
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import FormCostCenter from "@/components/FormCostCenter.vue";
import ListCostsCenters from "@/components/ListCostsCenters.vue";

export default {
  name: "CostCenter",
  components: {
    FormCostCenter,
    ListCostsCenters,
  },
};
</script>

<style>
</style>