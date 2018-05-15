 <template>
  <div>
    <label>{{ labels.companyName }}</label>
    <input  id="company-name"
            name="company-name"
            type="text"
            v-on:keyup="onKeyUp"
            v-on:blur="checkIfEmpty"
            v-on:keydown="keydown"
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
      this.$parent.$parent.$parent.setButtonStatus()
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

    keydown(event){
      if (event.keyCode == 13){
        event.preventDefault()
      }
    },

    checkIfEmpty(event){
      let isEmpty = event.target.value == ""
      this.$parent.setNameEmptyStatus(isEmpty)
    }
  }
}
</script>

<style scoped>
  label {
    margin-top: 1em;
  }
</style>
