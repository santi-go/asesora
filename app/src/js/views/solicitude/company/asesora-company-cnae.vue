  <template>
  <div>
    <label for="company-cnae">{{ labels.companyCnae }}
      <label  v-if="!values.companyCnae"
              class="fa fa-warning"
              :title="labels.required"
              :alt="labels.required">
      </label>
    </label>
    <basic-select id="company-cnae"
                  name="company-cnae"
                  :options="newCnaeCatalog"
                  :selected-option="itemCnae"
                  @select="onSelect"
                  :disabled="editCompany"
                  >
    </basic-select>
  </div>
</template>

<script>
import { BasicSelect } from 'vue-search-select'

export default {
  name: 'asesora-company-cnae',

  props: ['companyCnae', 'labels', 'values', 'cnaeCatalog', 'editCompany' ],

  computed: {
      newCnaeCatalog(){
        return this.parseCatalog(this.cnaeCatalog)
      }
  },

  watch: {
    companyCnae: function(newVal, oldVal) {
      this.itemCnae = this.searchCnaeInCatalog(newVal)
    }
  },

  data(){
    return {
      itemCnae:{},
      separator: ' - '
    }
  },

  methods: {
    onSelect(item) {
      this.values.companyCnae = item.text

      let signal = new CustomEvent('changed.company.cnae',
                                    {'detail': {'name': item.text},
                                    'bubbles': true})
        this.$el.dispatchEvent(signal)
    },

    fullCnaeName(cnaeCode){
      return cnaeCode.id + this.separator + cnaeCode.name
    },

    searchCnaeInCatalog(cnaeValue){
      let catalog = this.parseCatalog(this.cnaeCatalog)
      let result = catalog.find((el) => { return el.text == cnaeValue})
      if (result == undefined) {
        result = {values: 0, text: cnaeValue}
      }
      return result
    },

    parseCatalog(catalog){
      return this.cnaeCatalog.map((item) => {
               return {value:item.id,
                       text:this.fullCnaeName(item)}
            })
    }
  },

  components: {
    BasicSelect
  }
}
</script>
