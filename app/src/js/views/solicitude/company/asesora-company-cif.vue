<template>
  <div>
    <label>{{ labels.companyCif }}</label>
    <input  id="company-cif"
            name="company-cif"
            type="text"
            v-on:keyup="onKeyUp"
            v-on:focus="onFocus"
            v-on:keydown="keydown"
            v-on:blur="checker"
            v-model="values.companyCif"
            >
  </div>
</template>

<script>
export default {
  name: 'asesora-company-cif',

  props: ['labels', 'values', 'validatedcif'],

  watch: {
      validatedcif: function(event) {
        let inputCif = this.inputCif()
        this.isValidIfIsEmpty(inputCif)
        if (this.validatedcif == true) inputCif.classList.remove("error")
        if (this.validatedcif == false) inputCif.classList.add("error")
      }
  },

  methods: {
    inputCif(){
      return this.$el.querySelector("input[name=company-cif]")
    },

    isValidIfIsEmpty(inputCif){
      if (inputCif.value == "") this.validatedcif = true
    },

    onKeyUp(event){
      let inputCif = this.inputCif()
      inputCif.classList.remove("error")
      this.isValidIfIsEmpty(inputCif)
    },

    onFocus(event){
      event.target.classList.remove("error")
    },

    keydown(event){
      let isReturnKey = (event.keyCode == 13)
      if (isReturnKey) event.preventDefault()
    },

    checker(event){
      this.cifValidation(event)
      this.setStatusIfEmpty(event)
    },

    cifValidation(event){
      let signal = new CustomEvent('validate.cif',
                                  {'detail': {},
                                  'bubbles': true})
      this.$el.dispatchEvent(signal)
    },

    setStatusIfEmpty(event){
      let onEmpty = event.target.value == ""
      this.$parent.setCifEmptyStatus(onEmpty)
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
  label {
    margin-top: 1em;
  }

</style>
