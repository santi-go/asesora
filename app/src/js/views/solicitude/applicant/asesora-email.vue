<template>
  <div>
    <label>{{ labels.email }}</label>
    <input  id="email"
            name="email"
            type="text"
            v-on:blur="blur"
            v-on:focus="focus"
            v-on:keydown="keyDown"
            v-model="values.email"
            >
  </div>
</template>

<script>
export default {
  name: 'asesora-email',

  props: ['labels', 'values'],

  methods: {
    blur(){
      let valid = this.emailValidation()
      this.$parent.setValidEmail(valid)
    },

    focus(){
      event.target.className = ""
    },

    keyDown(event){
      let enter = 13
      if (event.keyCode == enter){
        event.preventDefault()
      }
    },

    emailValidation(){
      let field = this.$el.querySelector('#email')
      field.className = ""
      const EMAIL_PATTERN = /^[_a-z0-9-]+(.[_a-z0-9-]+)*@[a-z0-9-]+(.[a-z0-9-]+)*(.[a-z]{2,4})$/
      let email = field.value
      if(email == ""){
        return false
      }else if(!EMAIL_PATTERN.test(email)){
        field.className = "error"
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
