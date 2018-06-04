<template>
  <div>
    <div class="card-title">
      <h3>{{ labels.listTitle }}</h3>
    </div>
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
        <tr v-on:click="solicitudeEdit(item.creation_moment)"
            v-for="item in solicitudes">
          <td>{{ labels.notApply }}</td>
          <td>{{ item.date | es }}</td>
          <td>
            <template v-if=" item.name =='' && item.surname =='' ">{{ labels.notApply }}</template>
            <template v-else>{{ item.name }} {{ item.surname }}</template>
          </td>
          <td>
            <template v-if=" item.company_name == '' ">{{ labels.notApply }}</template>
            <template v-else>{{ item.company_name }}</template>
          </td>
          <td>{{ labels.notApply }}</td>
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
    },
      methods: {
        solicitudeEdit(id){
          let signal = new CustomEvent('load.solicitude',
                                      {'detail': id,
                                      'bubbles': true})
          this.$el.dispatchEvent(signal)
        }
    }

    }
  </script>
