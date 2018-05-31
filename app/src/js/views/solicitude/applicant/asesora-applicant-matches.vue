<template>
  <div>
    <label>{{ labels.suggestions }}</label>
    <table v-if="suggestedApplicants.length > 0">
      <thead>
        <tr>
          <th>{{ labels.applicantName }}</th>
          <th>{{ labels.applicantSurname }}</th>
          <th>{{ labels.applicantEmail }}</th>
          <th>{{ labels.applicantPhonenumber }}</th>

        </tr>
      </thead>
      <tbody>
        <tr v-on:click="onClick(item)"
            v-for="item in suggestedApplicants">
            <td>{{ item.name }}</td>
            <td>{{ item.surname }}</td>
            <td>{{ item.email }}</td>
            <td>{{ item.phonenumber }}</td>
        </tr>
      </tbody>
    </table>
  </div>
</template>

<script>
  export default {
    name: 'asesora-applicant-matches',
    props: ['labels', 'suggestedApplicants'],

    methods: {

      onClick(item){
          this.selectApplicant(item)
      },

      selectApplicant(item){
        let signal = new CustomEvent('clicked.applicant',
                                    {'detail': item,
                                    'bubbles': true})
        this.$el.dispatchEvent(signal)
      }
    }
  }

</script>
<style scoped>
  table{
    width: 100%;
    height: 335px;
    overflow: auto;
    display: block;
  }

  td{
    cursor: pointer;
  }
  label{
    margin-top: 1em;
  }
</style>
