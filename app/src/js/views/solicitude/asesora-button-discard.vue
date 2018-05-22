<template>
  <div class="button-inline">
    <button  id="discard"
            type="button"
            name="discard"
            class="discardbutton button-clear"
            v-on:click="onclick()">
      {{ labels.editiondiscard }}
    </button>
  </div>
</template>

<script>
export default {

  name: 'asesora-button-discard',

  props: ['labels'],

  methods: {
    onclick() {
      let signal = new CustomEvent('clicked.discard.button',
                                  {'detail': {},
                                  'bubbles': true})
      this.$el.dispatchEvent(signal)
    },
  }
}
</script>

<style scoped>
</style>
