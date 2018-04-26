 <template>
  <div>
    <label>{{ labels.companyCif }}</label>
    <input  id="company-cif"
            name="company-cif"
            type="text"
            v-on:keydown="keydown"
            v-on:blur="checkIfEmpty"
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
    },

    checkIfEmpty(event){
      let isEmpty = event.target.value == ""
      this.$parent.setCifEmptyStatus(isEmpty)
    }
  }
}
</script>

<style scoped>
  label {
    margin-top: 1em;
  }

</style>
