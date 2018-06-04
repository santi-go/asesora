 <template>
  <div>
    <label>{{ labels.companyCnae }}</label>
    <input  id="company-cnae"
            name="company-cnae"
            type="text"
            list="cnae-catalog"
            v-on:keyup="cnaeValidation"
            v-on:blur="cnaeValidation"
            :disabled="editCompany"
            v-model="values.companyCnae"
            >
        <datalist id="cnae-catalog">
            <option v-for="item in cnaeCatalog">
              {{ fullCnaeName(item) }}
            </option>
        </datalist>
  </div>
</template>

<script>
export default {
  name: 'asesora-company-cnae',

  props: ['labels', 'values', 'cnaeCatalog','editCompany'],

  data(){
    return {
      separator: ' - '
    }
  },

  methods: {
    fullCnaeName(cnaeCode){
      return cnaeCode.id + this.separator + cnaeCode.name
    },

    cnaeValidation(event){
      let value = event.target.value
      let id = value.split(this.separator)[0]

      let validCnae = this.cnaeCatalog.find(function(cnaeCode){
        return cnaeCode.id === id
      })

      if (validCnae) {
        event.target.value = this.fullCnaeName(validCnae)
        }

      let signal = new CustomEvent('changed.company.cnae',
                                  {'detail': {
                                    'name': this.values.companyName,
                                    'cnae': this.values.companyCnae
                                  },
                                  'bubbles': true})
      this.$el.dispatchEvent(signal)
    }
  }
}
</script>
