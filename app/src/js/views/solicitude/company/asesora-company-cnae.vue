 <template>
  <div>
    <label>{{ labels.companyCnae }}</label>
    <input  id="company-cnae"
            name="company-cnae"
            type="text"
            v-on:keydown="keydown"
            v-model="values.companyCnae"
            >
    </div>
</template>

<script>
export default {
  name: 'asesora-company-cnae',

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
