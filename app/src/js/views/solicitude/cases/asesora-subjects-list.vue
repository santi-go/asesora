<template>
  <div>
    <div class="card-title">
      <h3>{{ labels.subjectsList }}</h3>
    </div>
    <table>
      <tr v-for="item in values.subjects">
        <td>
          <label>{{ labels.proposals }}</label>
          <p>{{ item.proposal }}</p>
          <label>{{ labels.analysis }}</label>
          <p>{{ item.analysis }}</p>
          <label>{{ labels.topics }}</label>
          <p>{{ item.topics }}</p>
        </td>
      </tr>
    </table>
  </div>
</template>

<script>
  export default {
    name: 'asesora-subjects-list',
    props: ['labels', 'values']
  }
  </script>
