<template>
  <div>
    <label for="analysis-solicitude">{{ labels.analysis }}</label>
    <textarea id="analysis-solicitude"
              maxlength="200"
              placeholder="Máximo 200 caracteres"
              v-model="values.analysis"
              v-on:keydown="keyDown">
    </textarea>
  </div>
</template>

<script>
export default {
  name: 'asesora-analysis-for-solicitude',

  props: ['labels', 'values'],

  methods: {
    keyDown(event){
      let signal = new CustomEvent('changed.analysis',
                                    {'detail': "",
                                    'bubbles': true})
      this.$el.dispatchEvent(signal)
    }
  }
}
</script>
<style scoped>
textarea::placeholder {
  text-align: left;
  font-size: 0.8em;
  color: grey;
  font-family: "Open Sans", "Helvetica Neue", Helvetica, Arial, sans-serif;
}
</style>
