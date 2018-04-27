 <template>
  <div>
    <label>{{ labels.companyEmployees }}</label>
    <input  id="company-employees"
            name="company-employees"
            type="text"
            v-on:keydown="keydown"
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
    }
  }
}
</script>

<style scoped>
  label {
    margin-top: 1em;
  }

</style>
