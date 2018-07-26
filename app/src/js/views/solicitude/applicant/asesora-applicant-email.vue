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
      let signal = new CustomEvent('changed.email',
                                      {'detail': {},
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

  }
}
</script>

<style scoped>
  .error {
    border: 1px solid var(--error-color) !important;
  }
</style>
