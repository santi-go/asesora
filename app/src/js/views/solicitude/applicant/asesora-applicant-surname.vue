 <template>
  <div>
    <label>{{ labels.surname }}</label>
    <input  id="surname"
            name="surname"
            type="text"
            v-on:keydown="keydown"
            v-on:blur="blur"
            v-model="values.surname"
            >
    </div>
</template>

<script>
export default {
  name: 'asesora-applicant-surname',

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
</style>
