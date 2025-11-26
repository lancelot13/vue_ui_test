<script setup lang="ts">
import { ref, onMounted } from "vue";
import axios from "axios";

interface Product {
  id: number;
  name: string;
  price: number;
}

const products = ref<Product[]>([]);
const isLoading = ref<boolean>(true);
const error = ref<string | null>(null);

const fetchProducts = async () => {
    const api_url = "http://localhost:8081/products";
  // const api_url = "http://0.0.0.0:8081/products";
  isLoading.value = true;
  error.value = null;

  try {
    const response = await axios.get<Product[]>(api_url);
    products.value = response.data;
  } catch (err) {
    if (axios.isAxiosError(err)) {
      console.error("Axios Error fetching products:", err.message);
      error.value = `ไม่สามารถดึงข้อมูลสินค้าได้: ${err.message}`;
    } else {
      console.error("Unknown Error:", err);
      error.value = "เกิดข้อผิดพลาดที่ไม่ทราบสาเหตุ";
    }
  } finally {
    isLoading.value = false;
  }
};

onMounted(() => {
  fetchProducts();
});
</script>

<template>
  <div>
    <h3>รายการสินค้า</h3>
    <router-link to="/add-product">
      <button>Add Product</button>
    </router-link>
    <!-- <button @click="$router.push('/add-product')">Add Product</button> -->
    <div v-if="isLoading">กำลังโหลดข้อมูล</div>
    <div v-else-if="error" class="error-message">
      {{ error }}
    </div>
    <table v-else-if="products.length">
      <thead>
        <tr>
          <td>Id</td>
          <td>Name</td>
          <td>price</td>
        </tr>
      </thead>
      <tbody>
        <tr v-for="product in products" :key="product.id">
          <td>{{ product.id }}</td>
          <td>{{ product.name }}</td>
          <td>{{ product.price }}</td>
        </tr>
      </tbody>
    </table>
    <div v-else>ไม่พบข้อมูล</div>
  </div>
</template>
<style scoped>
/* Style เพื่อจัดตารางให้ดูดี */
table {
  width: 100%;
  border-collapse: collapse;
  margin-top: 20px;
}

th,
td {
  border: 1px solid #ddd;
  padding: 12px;
  text-align: left;
}

th {
  background-color: #42b883; /* สี Vue */
  color: white;
}

.error-message {
  color: #c0392b;
  font-weight: bold;
  padding: 10px;
  border: 1px solid #c0392b;
  background-color: #f7e8e8;
  border-radius: 4px;
}
</style>
