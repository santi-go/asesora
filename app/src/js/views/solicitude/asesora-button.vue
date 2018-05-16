<template>
  <div class="button-inline">
    <button  id="submit"
            type="button"
            name="submit"
            class="submitbutton"
            :disabled="!submittable"
            v-on:click="submit()">
      {{ labels.submit }}
    </button>
  </div>
</template>

<script>
export default {
  name: 'asesora-button',

  props: ['labels', 'values', 'editionmode', 'submittable'],

  methods: {

    submit(){
      let event = 'submit.solicitude'
      if (this.editionmode) {
        event = 'edit.solicitude'
      }

      let signal = new CustomEvent(event,
                                  {'detail': {},
                                  'bubbles': true})
      this.$el.dispatchEvent(signal)
      let button = this.$el.querySelector('button')
      button.innerText = this.labels.submitting
      button.disabled = true
    }
  }
}
</script>

<style scoped>
</style>
