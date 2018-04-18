<template>
  <div>
    <h1>Tus asesoramientos</h1>
    <table>
      <thead>
        <tr>
          <th>{{ labels.code }}</th>
          <th>{{ labels.date }}</th>
          <th>{{ labels.applicant }}</th>
          <th>{{ labels.company }}</th>
          <th>{{ labels.topics }}</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="item in solicitudes" :key="item.creation_moment">
          <td>n/a</td>
          <td>{{ item.date | es }}</td>
          <td>{{ item.applicant }}</td>
          <td>n/a</td>
          <td>n/a</td>
        </tr>
      </tbody>
    </table>
  </div>
</template>

<script>
  export default {
    name: 'asesora-solicitudes-list',
    props: ['labels', 'solicitudes'],
    filters: {
      es: function (date_en) {
        const date_parts = date_en.split('-')
        return date_parts.reverse().join('/')
      }
    }
  }
</script>
