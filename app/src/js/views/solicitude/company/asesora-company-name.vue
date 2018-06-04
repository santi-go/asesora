 <template>
  <div>
    <label>{{ labels.companyName }}</label>
    <input  id="company-name"
            name="company-name"
            type="text"
            v-on:keyup="onKeyup"
            :disabled="editCompany"
            v-model="values.companyName"
            >
    </div>
</template>

<script>
export default {
  name: 'asesora-company-name',

  props: ['labels', 'values', 'editCompany'],

  methods: {
    onKeyup(){
      this.searchCompaniesMatch()
      this.validateCompanyIdentity()

    },

    searchCompaniesMatch() {
      let signal = new CustomEvent('changed.company.name',
                                      {'detail': {
                                          'name': this.values.companyName,
                                          'cnae': this.values.companyCnae
                                      },
                                      'bubbles': true})
      this.$el.dispatchEvent(signal)
    },

    validateCompanyIdentity(){
      let signal = new CustomEvent('validate.company.identity',
                                      {'detail': {},
                                      'bubbles': true})
      this.$el.dispatchEvent(signal)
    }
  }
}
</script>
