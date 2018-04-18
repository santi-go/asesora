<template>
  <div>
    <button  id="submit"
            type="button"
            name="submit"
            class="submitbutton"
            v-bind:disabled="true"
            v-on:click="submit()">
      {{ labels.submit }}
    </button>
  </div>
</template>

<script>
export default {

  props: ['labels', 'values'],

  methods: {

    submit(){
      let signal = new CustomEvent('submit.solicitude',
                                  {'detail': {},
                                  'bubbles': true})
      this.$el.dispatchEvent(signal)
      let button = this.$el.querySelector('button')
      button.value = this.labels.submitting
      button.disabled = true
    }
  }
}
</script>

<style scoped>
</style>
