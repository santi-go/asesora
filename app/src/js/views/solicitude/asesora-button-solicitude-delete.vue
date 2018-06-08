<template>
  <div class="button-inline">
    <button id="delete-solicitude"
            type="button"
            name="delete"
            class="submitbutton delete"
            v-on:click="submit()">
      {{ labels.deleteSolicitude }}
    </button>
  </div>
</template>

<script>
export default {
  name: 'asesora-button',

  props: ['labels', 'values'],

  methods: {
    submit(){
      let signal = new CustomEvent('clicked.delete.solicitude',
                                  {'detail': {'solicitudeId': this.values.creation_moment },
                                  'bubbles': true})
      this.$el.dispatchEvent(signal)
    }
  }
}
</script>
<style scoped>
  .delete {
    background-color: var(--grey-color);
    border-color: var(--grey-color);
  }
</style>
