import { createRouter, createWebHistory } from "vue-router";
import ProductsList from "../components/ProductsList.vue";
import ProductsForm from "../components/ProductsForm.vue";


const routes=[
    { path: "/",component: ProductsList},
    { path: "/add-product", component: ProductsForm},
  ]
const router = createRouter({
    history: createWebHistory(import.meta.env.BASE_URL),
    routes
});

export default router;
