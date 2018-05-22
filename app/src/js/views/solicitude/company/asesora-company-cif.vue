<template>
  <div>
    <label>{{ labels.companyCif }}</label>
    <input  id="company-cif"
            name="company-cif"
            type="text"
            v-on:keyup="checker"
            v-model="values.companyCif"
            :disabled="editionmode"
            v-bind:class="{ error: !isValidCif}"
            >
  </div>
</template>

<script>
export default {
  name: 'asesora-company-cif',

  props: ['labels', 'values', 'isValidCif', 'editionmode'],

  methods: {

    checker(){
      this.ensureCif()
      this.validateCompanyIdentity()
    },

    validateCompanyIdentity(){
      let signal = new CustomEvent('validate.company.identity',
                                      {'detail': {},
                                      'bubbles': true})
      this.$el.dispatchEvent(signal)
    },

    ensureCif(){
      let signal = new CustomEvent('ensure.cif',
                                  {'detail': {},
                                  'bubbles': true})
      this.$el.dispatchEvent(signal)
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
