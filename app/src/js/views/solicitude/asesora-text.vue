<template>
  <div>
    <label>{{ labels.text }}</label>
    <textarea id="solicitude-text"
              placeholder="*"
              v-on:keyup="onKeyup"
              v-on:focus="onFocus"
              :disabled="!editCompany"
              v-model="values.text">
    </textarea>
  </div>
</template>

<script>
export default {
  name: 'asesora-text',

  props: ['labels', 'values','editCompany'],

  methods: {
    onKeyup(event){
      event.target.classList.remove("error")
      if (event.target.value == "") {
        event.target.classList.add("error")
      }

      let signal = new CustomEvent('changed.text',
                                      {'detail': {},
                                      'bubbles': true})
      this.$el.dispatchEvent(signal)
    },

    onFocus(event){
      event.target.classList.remove("error")
    }
  }
}
</script>

<style scoped>

  textarea{
    min-height: 200px;
    width: 100%;
  }
  textarea::placeholder {
    text-align: right;
    font-size: 2em;
    color: var(--error-color);
  }
  .error {
    border: 1px solid var(--error-color) !important;
  }
</style>
