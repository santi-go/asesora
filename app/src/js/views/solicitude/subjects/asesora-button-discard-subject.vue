<template>
  <div class="button-inline">
    <button type="button"
            class="discardbutton button-clear"
            v-on:click="onclick()">
      {{ labels.discardButtonSubject }}
    </button>
  </div>
</template>

<script>
export default {
  name: 'asesora-button-discard-subject',

  props: ['labels'],

  methods: {
    onclick() {
      let signal = new CustomEvent('clicked.discard.subject.button',
                                  {'detail': {},
                                  'bubbles': true})
      this.$el.dispatchEvent(signal)
    },
  }
}
</script>

<style scoped>
</style>
