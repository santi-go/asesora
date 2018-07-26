<template>
  <div>
    <div class="card-title">
      <h2>{{ labels.listTitle }}</h2>
    </div>
    <table>
      <thead>
        <tr>
          <th>{{ labels.code }}</th>
          <th>{{ labels.date }}</th>
          <th>{{ labels.applicant }}</th>
          <th>{{ labels.company }}</th>
          <th>{{ labels.subjects }}</th>
          <th>{{ labels.feprl }}</th>
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
          <td>
            <template v-if="item.subjects">
              <label :title='titleForJustifiedSubjects(item.subjects)'>
                {{ justifiedSubjects(item.subjects) }}/{{ item.subjects.length }}
              </label>
            </template>
              <template v-else>
                <label :title='labels.titleWithoutSubject'>
                  {{ labels.zeroSubjects }}
                </label>
              </template>
          </td>

          <td>
            <template v-if="justifiedSolicitude(item)">
              <i id="check" class="fa fa-check fa-2"></i>
            </template>
          </td>

          <td>
            <a class="solicitude-show-button"
               v-on:click='showSolicitude(item.creation_moment)'>
               {{ labels.show }}
            </a>
          </td>
          <td>
            <a class="solicitude-edit-button"
               v-on:click='solicitudeEdit(item.creation_moment)'>
               {{ labels.edit }}
            </a>
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
      titleForJustifiedSubjects(subjects){
        return this.justifiedSubjects(subjects) + this.labels.of + subjects.length + this.labels.justifiedSubjects
      },


      justifiedSubjects(subjects){
        if (subjects == null) {
          return 0
        }
        let justified = 0
        for(let subject of subjects){
         if(subject.topics.length > 0
           && subject.proposal.length > 0){
             justified = justified + 1
           }
         }
         return justified
      },

      justifiedSolicitude(item){
        if(item.date &&
           item.company_cnae &&
           item.company_employees &&
           item.source.text &&
           item.ccaa.text){
             return true
          }
        return false
      },

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
<style scoped>
#check {
  color: #35cebe;
}
a {
  cursor: pointer;
  font-weight: bold;
}
label {
  font-weight: normal;
}
</style>
