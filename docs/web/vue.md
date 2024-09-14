# 开发技巧
## 条件渲染
## 监听
```js
<script setup>
import { ref,watch } from 'vue'

const todoId = ref(1)
const todoData = ref(null)
const count = ref(0)

watch(todoId,(newTodoId) =>{
  console.log(`new newTodoId is: ${todoId.value}`)
  fetchData()
})

async function fetchData() {
  todoData.value = null
  const res = await fetch(
    `https://jsonplaceholder.typicode.com/todos/${todoId.value}`
  )
  todoData.value = await res.json()
}

fetchData()
</script>

<template>
  <p>Todo id: {{ todoId }}</p>
  <button @click="todoId++" :disabled="!todoData">Fetch next todo</button>
  <p v-if="!todoData">Loading...</p>
  <pre v-else>{{ todoData }}</pre>
</template>
```
## 计算
## el-tree 标题过长换行

```css
.el-tree {
  width: 320px;
  ::v-deep .el-tree-node {
    white-space: normal;
    .el-tree-node__content {
      height: 100%;
      align-items: start;
    }
  }
}
```
## 组件
- TodoItem
```js
<script setup>
const props = defineProps({
  todo: Object
})
</script>

<template>
  <li>{{ todo.text }}</li>
</template>
```
- App.vue
```js
<script setup>
import { ref } from 'vue'
import TodoItem from './TodoItem.vue'

const groceryList = ref([
  { id: 0, text: 'Vegetables' },
  { id: 1, text: 'Cheese' },
  { id: 2, text: 'Whatever else humans are supposed to eat' }
])
</script>

<template>
  <ol>
    <TodoItem
      v-for="item in groceryList"
      :todo="item"
      :key="item.id"
    ></TodoItem>
  </ol>
</template>
```
## 父子组件通信
## 插槽
## 下载文件

```js
async downloadZip() {
    try {
        const response = await axios.get('http://localhost:10000/export?id=1821390347223298049', {
            responseType: 'blob', // 处理二进制数据
        });

        const url = window.URL.createObjectURL(new Blob([response.data]));
        const link = document.createElement('a');
        link.href = url;
        link.setAttribute('download', 'sample.zip'); // 下载的文件名
        document.body.appendChild(link);
        link.click();
        link.remove();
    } catch (error) {
        console.error('Error downloading the file:', error);
    }
},
```

## 捕获后端全局异常
```js
let params = {"datasourceId":"1815938690683367425","dirId":"","fileName":"22","fileTypes":[],"folderId":"","sortQuery":{"sortType":0,"up":true},"taskId":"","pageIndex":0,"pageNo":0,"pageSize":9999};
axios.post('http://localhost:10000/email/importTask/exportImportOtherFiles', params, { responseType: 'blob' })
.then(response => {
    if (response.headers['content-type'].includes('application/json')) {
        // 错误信息以 JSON 格式返回
        const reader = new FileReader();
        reader.onload = () => {
            const errorData = JSON.parse(reader.result);
            console.error('Error message:', errorData.message);
            console.error('Error details:', errorData.details);
            this.$message.error(`Download failed: ${errorData.message}`);
        };
        reader.readAsText(response.data);
    } else {
        // 正常的文件下载
        const url = window.URL.createObjectURL(new Blob([response.data]));
        const link = document.createElement('a');
        link.href = url;
        link.setAttribute('download', `export_${Date.now()}.zip`);
        document.body.appendChild(link);
        link.click();
        link.remove();
    }
})
```

