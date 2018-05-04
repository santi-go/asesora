 <template>
  <div>
    <label>{{ labels.companyCnae }}</label>
    <input  id="company-cnae"
            name="company-cnae"
            type="text"
            list="cnae-catalog"
            v-on:keydown="keydown"
            v-on:blur="onBlur"
            v-model="values.companyCnae"
            >
        <datalist id="cnae-catalog">
            <option v-for="item in cnaecatalog">
              {{ item.id + " - " + item.name}}
            </option>
        </datalist>
  </div>
</template>

<script>
export default {
  name: 'asesora-company-cnae',

  props: ['labels', 'values', 'cnaecatalog'],

  methods: {
    keydown(event){
      if (event.keyCode == 13){
        event.preventDefault()
      }
    },

    onBlur(event){
      let value = event.target.value
      return value
    }
  }
}
</script>

<style scoped>
  label {
    margin-top: 1em;
  }

</style>
