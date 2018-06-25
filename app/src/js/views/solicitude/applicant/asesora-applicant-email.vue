<template>
  <div>
    <label for="email">{{ labels.applicantEmail }}</label>
    <input  id="email"
            name="email"
            type="text"
            v-on:focus="focus"
            v-on:keyup="onKeyup"
            v-model="values.applicantEmail"
            >
      <div id="contact-email" v-if="!isValidEmail">
        <div class="alert background-danger">
          <em class="fa fa-times-circle"></em>
          {{ labels.errorEmail }}
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'asesora-applicant-email',

  props: ['labels', 'values', 'isValidEmail'],

  methods: {

    onKeyup(){
      let valid = this.emailValidation()
      let signal = new CustomEvent('changed.email',
                                      {'detail': {"valid":valid},
                                      'bubbles': true})
      this.$el.dispatchEvent(signal)
      this.refreshSuggestion()
    },

    refreshSuggestion() {
      let signal = new CustomEvent('changed.applicant.fields',
                                      {'detail': {},
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
