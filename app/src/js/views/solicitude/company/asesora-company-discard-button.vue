<template>
  <div class="button-inline">
    <button  id="discard-company"
            type="button"
            name="discard"
            class="discardbutton button-clear"
            v-on:click="discardCompany()">
      {{ labels.editiondiscard }}
    </button>
  </div>
</template>

<script>
export default {

  name: 'asesora-company-discard-button',

  props: ['labels'],

  methods: {
    discardCompany() {
      let signal = new CustomEvent('clicked.discard.company.button',
                                  {'detail': {},
                                  'bubbles': true})
      this.$el.dispatchEvent(signal)
    }
  }
}
</script>

<style scoped>
</style>
