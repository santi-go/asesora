 <template>
  <div>
    <label>{{ labels.companyCif }}</label>
    <input  id="company-name-cif"
            name="company-name-cif"
            type="text"
            v-on:keydown="keydown"
            v-model="values.companyCif"
            >
    </div>
</template>

<script>
export default {
  name: 'asesora-company-cif',

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
