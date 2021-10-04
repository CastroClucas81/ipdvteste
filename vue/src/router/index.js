import Vue from "vue";
import VueRouter from "vue-router";
import CostCenter from "../views/CostCenter.vue";
import Departament from "../views/Departament.vue";
import Office from "../views/Office.vue";
import Login from "../views/Login.vue";
import User from "../views/User.vue";
import Dashboard from "../views/Dashboard.vue";
import NotFound from "../views/NotFound.vue";
import Guard from "../services/middleware";

Vue.use(VueRouter);

const routes = [
  {
    path: "/",
    name: "Login",
    component: Login,
    beforeEnter: Guard.redirectToDashboard,
  },
  {
    path: "/office",
    name: "Office",
    component: Office,
  },
  {
    path: "/departament",
    name: "Departament",
    component: Departament,
  },
  {
    path: "/cost-center",
    name: "CostCenter",
    component: CostCenter,
  },
  {
    path: "/user",
    name: "User",
    component: User,
  },
  {
    path: "/dashboard",
    name: "Dashboard",
    beforeEnter: Guard.auth,
    component: Dashboard,
  },
  {
    path: "/:catchAll(.*)",
    name: "NotFound",
    component: NotFound,
  },
];

const router = new VueRouter({
  mode: "history",
  base: process.env.BASE_URL,
  routes,
});

export default router;
