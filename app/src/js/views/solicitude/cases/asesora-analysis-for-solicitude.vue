<template>
  <div>
    <label for="analysis-solicitude">{{ labels.analysis }}</label>
    <textarea id="analysis-solicitude"
              placeholder="Máximo 200 palabras"
              v-model="values.analysis"
              v-on:keydown="keyDown"
              v-on:keyup="changeLimitationSpace"
              >
    </textarea>
  </div>
</template>

<script>
export default {
  name: 'asesora-analysis-for-solicitude',

  props: ['labels', 'values'],

  methods: {
    changeLimitationSpace(event) {
      let maximumWordsSize = 200
      let analysis = this.values.analysis
      let words = analysis.split(/\s+/).length
      let isMaxLength = (words > maximumWordsSize)
      if (isMaxLength) { this.limitLengthFrom(analysis) }
      if (!isMaxLength) { this.unblockLength() }
    },

    limitLengthFrom(text) {
      let analysisArea = document.querySelector('#analysis-solicitude')
      let actualLength = text.length
      analysisArea.setAttribute('maxlength', actualLength.toString())
    },

    unblockLength() {
      let analysisArea = document.querySelector('#analysis-solicitude')
      analysisArea.removeAttribute('maxlength')
    },

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
