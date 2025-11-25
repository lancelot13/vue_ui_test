<script setup lang="ts">
  import ProductsList from './components/ProductsList.vue';
</script>

<template>
  <!-- <router-link to="/">Products</router-link>
  <router-link to="/add-product">Add Products</router-link> -->

  <div>
    <router-view></router-view>
  </div>
</template>

<style scoped>
/* .logo {
  height: 6em;
  padding: 1.5em;
  will-change: filter;
  transition: filter 300ms;
}
.logo:hover {
  filter: drop-shadow(0 0 2em #646cffaa);
}
.logo.vue:hover {
  filter: drop-shadow(0 0 2em #42b883aa);
} */
</style>
