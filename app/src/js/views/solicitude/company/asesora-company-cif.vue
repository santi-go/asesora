<template>
  <div>
    <label for="company-cif">{{ labels.companyCif }}</label>
    <input  id="company-cif"
            name="company-cif"
            type="text"
            v-on:keyup="emitSignal"
            v-model="values.companyCif"
            :disabled="editCompany"
            v-bind:class="{ error: !isValidCif}"
            >
  </div>
</template>

<script>
export default {
  name: 'asesora-company-cif',

  props: ['labels', 'values', 'isValidCif','editCompany'],

  methods: {

    emitSignal(){
      let signal = new CustomEvent('changed.company.cif',
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
</style>
