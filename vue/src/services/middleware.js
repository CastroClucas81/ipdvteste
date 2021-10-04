import Cookie from "js-cookie";

export default {
  auth(to, from, next) {
    const token = Cookie.get("token");
    //chegar validade do token... implementar
    if (!token) {
      next("/");
    }

    next();
  },

  redirectToDashboard(to, from, next) {
    const token = Cookie.get("token");
    if (token) {
      next("/dashboard");
    }
    next();
  },
};
