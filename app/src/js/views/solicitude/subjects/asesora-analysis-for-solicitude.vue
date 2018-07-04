<template>
  <div>
    <label for="analysis-solicitude">{{ labels.analysis }}</label>
    <textarea id="analysis-solicitude"
              :placeholder= "labels.placeholderAnalysis"
              v-model="values.analysis"
              v-on:keyup="checksInputCurrentState"
              >
    </textarea>
    <em>{{ labels.max200Words }}</em>
  </div>
</template>

<script>
export default {
  name: 'asesora-analysis-for-solicitude',

  props: ['labels', 'values'],

  methods: {
    checksInputCurrentState(event){
      this.changeLimitationSpace(event)
      this.emitSignal(event)
    },

    emitSignal(event) {
      let signal = new CustomEvent('changed.subject',
                                  {'detail': "",
                                  'bubbles': true})
      this.$el.dispatchEvent(signal)
    },

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
    }
  }
}
</script>
<style scoped>
  em {
    font-size: 1.5rem;
  }
  textarea::placeholder {
    text-align: left;
    font-size: 1em;
    color: grey;
    font-family: "Open Sans", "Helvetica Neue", Helvetica, Arial, sans-serif;
  }
</style>
