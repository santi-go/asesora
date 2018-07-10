<template>
  <div>
    <label for="solicitude-proposals-description">{{ labels.proposalsDescription }}</label>
    <textarea id="solicitude-proposals-description"
              :placeholder="labels.placeholderProposalsDescription"
              v-on:keyup="onKeyup"
              v-model="values.proposalsDescription">
    </textarea>
  </div>
</template>

<script>
export default {
  name: 'solicitude-proposals-description',

  props: ['labels', 'values'],

  methods: {
    onKeyup(event){
      let signal = new CustomEvent('changed.proposals.description',
                                      {'detail': {},
                                      'bubbles': true})
      this.$el.dispatchEvent(signal)
    }
  }
}
</script>
