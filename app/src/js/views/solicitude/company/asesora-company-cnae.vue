 <template>
  <div>
    <label>{{ labels.companyCnae }}</label>
    <input  id="company-cnae"
            name="company-cnae"
            type="text"
            list="cnae-catalog"
            v-on:keydown="keydown"
            v-on:blur="cnaeValidation"
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

  props: ['labels', 'values', 'cnaeCatalog'],

  data(){
    return {
      separator: ' - '
    }
  },

  methods: {
    fullCnaeName(cnaeCode){
      return cnaeCode.id + this.separator + cnaeCode.name
    },

    keydown(event){
      if (event.keyCode == 13){
        event.preventDefault()
      }
    },

    cnaeValidation(event){
      let value = event.target.value
      let id = value.split(this.separator)[0]

      let validCnae = this.cnaeCatalog.find(function(cnaeCode){
        return cnaeCode.id === id
      })
      event.target.value = ""

      if (validCnae) {
        event.target.value = this.fullCnaeName(validCnae)
        }

      let signal = new CustomEvent('search.companies',
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

<style scoped>
  label {
    margin-top: 1em;
  }

</style>
