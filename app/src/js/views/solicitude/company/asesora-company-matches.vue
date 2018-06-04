<template>
  <div>
    <label>{{ labels.suggestions }}</label>
    <table v-if="suggestedCompanies.length > 0">
      <thead>
        <tr>
          <th>{{ labels.companyName }}</th>
          <th>{{ labels.companyCif }}</th>
          <th>{{ labels.companyCnae }}</th>
        </tr>
      </thead>
      <tbody>
        <tr v-on:click="onClick(item)"
            v-for="item in suggestedCompanies">
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
    props: ['labels', 'suggestedCompanies','validatedcif'],

    methods: {

      onClick(item){
          this.selectCompany(item)
          this.validateCompanyIdentity()
      },

      selectCompany(item){
        let signal = new CustomEvent('clicked.company',
                                    {'detail': item,
                                    'bubbles': true})
        this.$el.dispatchEvent(signal)
        this.validatedcif = true
      },

      validateCompanyIdentity(){
        let signal = new CustomEvent('validate.company.identity',
                                        {'detail': {},
                                        'bubbles': true})
        this.$el.dispatchEvent(signal)
      },
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
</style>
