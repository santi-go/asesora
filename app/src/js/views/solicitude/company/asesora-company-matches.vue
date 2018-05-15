<template>
  <div>
    <label>{{ labels.suggestions }}</label>
    <table>
      <thead>
        <tr>
          <th>{{ labels.companyName }}</th>
          <th>{{ labels.companyCif }}</th>
          <th>{{ labels.companyCnae }}</th>
        </tr>
      </thead>
      <tbody>
        <tr v-on:click="selectCompany(item)"
            v-for="item in suggestedcompanies">
            <td>{{ item.name }}</td>
            <td>{{ item.cif }}</td>
            <td>{{ item.cnae }}</td>
        </tr>
      </tbody>
    </table>
  </div>
</template>

<script>
  export default {
    name: 'asesora-company-matches',
    props: ['labels', 'suggestedcompanies'],

    methods: {
      selectCompany(item){
        let signal = new CustomEvent('fill.company',
                                    {'detail': item,
                                    'bubbles': true})
        this.$el.dispatchEvent(signal)
      }
    }
  }

</script>
<style>
  td{
    cursor: pointer;
  }
  label{
    margin-top: 1em;
  }
</style>
