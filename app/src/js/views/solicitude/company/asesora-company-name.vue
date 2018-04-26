 <template>
  <div>
    <label>{{ labels.companyName }}</label>
    <input  id="company-name"
            name="company-name"
            type="text"
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
