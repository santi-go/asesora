<template>
  <div>
    <label>{{ labels.email }}</label>
    <input  id="email"
            name="email"
            type="text"
            v-on:blur="blur"
            v-on:focus="focus"
            :disabled="editionmode"
            v-model="values.email"
            >
  </div>
</template>

<script>
export default {
  name: 'asesora-email',

  props: ['labels', 'values', 'editionmode'],

  methods: {
    blur(event){
      let valid = this.emailValidation()
      let signal = new CustomEvent('status.email',
                                      {'detail': {"valid":valid},
                                      'bubbles': true})
      this.$el.dispatchEvent(signal)
    },

    focus(event){
      event.target.classList.remove("error")
    },

    emailValidation(){
      let field = this.$el.querySelector('#email')
      field.classList.remove("error")
      const EMAIL_PATTERN = /^[_a-z0-9-]+(.[_a-z0-9-]+)*@[a-z0-9-]+(.[a-z0-9-]+)*(.[a-z]{2,4})$/
      let email = field.value
      if(email == ""){
        return false
      }else if(!EMAIL_PATTERN.test(email)){
        field.classList.add("error")
        return false
      }
      return true
    }
  }
}
</script>

<style scoped>
  .error {
    border: 1px solid var(--error-color) !important;
  }
</style>
