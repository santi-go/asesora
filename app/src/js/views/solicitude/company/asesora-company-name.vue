 <template>
  <div>
    <label>{{ labels.companyName }}</label>
    <input  id="company-name"
            name="company-name"
            type="text"
            v-on:keyup="onKeyUp"
            v-on:blur="validateCompanyIdentity"
            v-model="values.companyName"
            >
    </div>
</template>

<script>
export default {
  name: 'asesora-company-name',

  props: ['labels', 'values'],

  methods: {
    onKeyUp(event){
      this.searchCompaniesMatch()
    },

    searchCompaniesMatch() {
      let signal = new CustomEvent('search.companies',
                                      {'detail': {
                                          'name': this.values.companyName,
                                          'cnae': this.values.companyCnae
                                      },
                                      'bubbles': true})
      this.$el.dispatchEvent(signal)
    },

    validateCompanyIdentity(event){
      let signal = new CustomEvent('validate.company.identity',
                                      {'detail': {},
                                      'bubbles': true})
      this.$el.dispatchEvent(signal)
    }
  }
}
</script>

<style scoped>
  label {
    margin-top: 1em;
  }
</style>
