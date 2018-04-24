<template>
  <div>
    <label>{{ labels.email }}:</label>
    <input  id="email"
            name="email"
            placeholder="*"
            type="text"
            v-on:keyup="onKeyUp"
            v-on:focus="onFocus"
            v-on:keydown="keydown"
            v-on:blur="emailValidation"
            v-model="values.email"
            >
  </div>
</template>

<script>
export default {
  name: 'asesora-email',

  props: ['labels', 'values'],

  methods: {
    onKeyUp(event){
      event.target.className = ""
      if (event.target.value == "") {
        event.target.className = "error"
      }
      this.$parent.setButtonStatus()
    },

    onFocus(){
      event.target.className = ""
    },

    keydown(event){
      let enter = 13
      if (event.keyCode == enter){
        event.preventDefault()
      }
    },

    emailValidation(){
      const EMAIL_PATTERN = /^[_a-z0-9-]+(.[_a-z0-9-]+)*@[a-z0-9-]+(.[a-z0-9-]+)*(.[a-z]{2,4})$/
      let email = event.target.value
      if(!EMAIL_PATTERN.test(email)){
          event.target.className = "error"
      }
    }
  }
}
</script>

<style scoped>

  input::placeholder {
    text-align: right;
    font-size: 2em;
    color: var(--error-color);
    line-height: 1.4em;
  }
  input::-webkit-input-placeholder {
    position: relative;
    top: 12px;
  }
  .error {
    border: 1px solid var(--error-color) !important;
  }
</style>
