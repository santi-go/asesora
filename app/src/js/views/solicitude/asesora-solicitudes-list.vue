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
        <tr v-for="item in solicitudes">
          <td>{{ labels.notApply }}</td>
          <td>{{ item.date | es }}</td>
          <td>
            <template v-if=" item.name =='' && item.surname =='' ">{{ labels.notApply }}</template>
            <template v-else>{{ item.name }} {{ item.surname }}</template>
          </td>
          <td>
            <template v-if=" item.company_name == undefined || item.company_name == '' ">{{ labels.notApply }}</template>
            <template v-else>{{ item.company_name }}</template>
          </td>
          <td>{{ labels.notApply }}</td>
          <td><button class="solicitude-show-button"
                      type="button"
                      name="button"button border="1"
                      v-on:click='showSolicitude(item.creation_moment)'>
                {{ labels.show }}
              </button>
          </td>
          <td><button class="solicitude-edit-button"
                      type="button"
                      name="button"button border="1"
                      v-on:click='solicitudeEdit(item.creation_moment)'>
                {{ labels.edit }}
              </button>
          </td>
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
        if (date_en === undefined) { return date_en }
        const date_parts = date_en.split('-')
        return date_parts.reverse().join('/')
      }
    },
    methods: {
      solicitudeEdit(id) {
        let signal = new CustomEvent('load.solicitude',
                                    {'detail': id,
                                    'bubbles': true})
        this.$el.dispatchEvent(signal)
      },
      showSolicitude(id) {
        let signal = new CustomEvent('show.solicitude',
                                    {'detail': id,
                                    'bubbles': true})
        this.$el.dispatchEvent(signal)
      }
    }
  }
</script>
