 <template>
  <div>
    <label>{{ labels.name }}</label>
    <input  id="name"
            name="name"
            type="text"
            v-on:keydown="keydown"
            v-on:blur="blur"
            v-model="values.name"
            >
    </div>
</template>

<script>
export default {
  name: 'asesora-applicant-name',

  props: ['labels', 'values'],

  methods: {
    keydown(event){
      if (event.keyCode == 13){
        event.preventDefault()
      }
    },
    blur(event){
      this.$parent.$parent.setButtonStatus()
    }
  }
}
</script>

<style scoped>
  label {
    margin-top: 1em;
  }
</style>
