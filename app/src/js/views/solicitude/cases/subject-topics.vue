<template>
  <div>
    <div class="card-title">
      <h3>{{ labels.topics }}</h3>
    </div>
    <table>
      <tr v-for="item in topicsCatalog">
        <td>{{ item.id }} -- {{ item.name }}</td>
      </tr>
    </table>
  </div>
</template>

<script>
  export default {
    name: 'subject-topics',
    props: ['labels', 'topicsCatalog']
  }
  </script>
