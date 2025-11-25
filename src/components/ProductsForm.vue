<script setup lang="ts">
import { ref } from "vue";
import axios from "axios";
import { useRouter } from 'vue-router'; // สำหรับนำทางกลับ

// กำหนด Type สำหรับข้อมูลที่จะส่ง
interface NewProduct {
  name: string;
  price: number;
}

const router = useRouter(); // ใช้สำหรับนำทาง
const newProduct = ref<NewProduct>({ name: '', price: 0 });
const submitStatus = ref<'idle' | 'loading' | 'success' | 'error'>('idle');
const errorMessage = ref<string | null>(null);

const handleSubmit = async () => {
    // 1. ตรวจสอบความถูกต้องเบื้องต้น
    if (!newProduct.value.name || newProduct.value.price <= 0) {
        errorMessage.value = "กรุณากรอกข้อมูลให้ครบถ้วนและราคาต้องมากกว่า 0";
        return;
    }

    const api_url = "http://127.0.0.1:8000/products";
    submitStatus.value = 'loading';
    errorMessage.value = null;

    try {
        // 2. ส่งข้อมูลแบบ POST
        const response = await axios.post(api_url, newProduct.value);
        
        console.log("Product Added:", response.data);
        submitStatus.value = 'success';
        
        // 3. เคลียร์ฟอร์มและกลับไปหน้ารายการสินค้า
        newProduct.value = { name: '', price: 0 };
        alert('เพิ่มสินค้าสำเร็จ!');
        router.push('/'); // นำทางกลับไปหน้าแรก (ProductList)

    } catch (err) {
        submitStatus.value = 'error';
        if (axios.isAxiosError(err)) {
            // ตรวจสอบสถานะ CORS อีกครั้ง หากยังไม่เปิดใน FastAPI
            errorMessage.value = `Error: ${err.message}. (ตรวจสอบ CORS ใน Backend)`;
        } else {
            errorMessage.value = 'เกิดข้อผิดพลาดในการส่งข้อมูล';
        }
    }
};

</script>

<template>
    <div class="form-container">
        <h3>เพิ่มสินค้าใหม่</h3>

        <form @submit.prevent="handleSubmit">
            <div class="form-group">
                <label for="name">ชื่อสินค้า (Name)</label>
                <input type="text" id="name" v-model="newProduct.name" required>
            </div>

            <div class="form-group">
                <label for="price">ราคา (Price)</label>
                <input type="number" id="price" v-model.number="newProduct.price" min="0.01" step="0.01" required>
            </div>

            <div class="status-message">
                <p v-if="submitStatus === 'loading'">กำลังส่งข้อมูล...</p>
                <p v-if="submitStatus === 'error'" class="error-message">{{ errorMessage }}</p>
            </div>

            <button type="submit" :disabled="submitStatus === 'loading'">บันทึกสินค้า</button>
        </form>
    </div>
</template>

<style scoped>
.form-container {
    max-width: 500px;
    margin: 30px auto;
    padding: 20px;
    border: 1px solid #ccc;
    border-radius: 8px;
}
.form-group {
    margin-bottom: 15px;
}
label {
    display: block;
    margin-bottom: 5px;
    font-weight: bold;
}
input[type="text"], input[type="number"] {
    width: 100%;
    padding: 10px;
    border: 1px solid #ddd;
    border-radius: 4px;
    box-sizing: border-box;
}
button {
    background-color: #007bff;
    color: white;
    padding: 10px 15px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-size: 1em;
}
button:disabled {
    background-color: #ccc;
    cursor: not-allowed;
}
.error-message {
  color: #c0392b;
  font-weight: bold;
}
.status-message {
    min-height: 20px;
    margin-bottom: 10px;
}
</style>