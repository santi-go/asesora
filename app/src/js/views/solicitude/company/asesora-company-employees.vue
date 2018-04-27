 <template>
  <div>
    <label>{{ labels.companyEmployees }}</label>
    <input  id="company-employees"
            name="company-employees"
            type="number"
            min="1"
            v-on:keypress="onlyNumbers"
            v-on:keydown="keydown"
            v-on:blur="checkNumber"
            v-model="values.companyEmployees"
            >
    </div>
</template>

<script>
export default {
  name: 'asesora-company-employees',

  props: ['labels', 'values'],

  methods: {
    keydown(event){
      if (event.keyCode == 13){
        event.preventDefault()
      }
    },
    onlyNumbers(event){
      if(event.charCode < 48 || event.charCode > 57){
        event.preventDefault()
      }
    },
    checkNumber(event){
      let value = event.target.value
      if(parseInt(value) < 1 ){
        event.target.value = ""
      }
    }
  }
}
</script>

<style scoped>
  label {
    margin-top: 1em;
  }

</style>
