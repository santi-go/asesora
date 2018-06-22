<template>
  <div class="button-inline">
    <button id='add-case-button'
            type="button"
            name="button"
            v-on:click='addSubject()'>
            {{ labels.addSubject }}
    </button>
  </div>
</template>

<script>
export default {

  name: 'asesora-button-create-case',

  props: ['labels', 'values'],

  methods: {
    addSubject(){
      let signal = new CustomEvent('clicked.create.case',
                                  {'detail': this.values.id,
                                  'bubbles': true})
      this.$el.dispatchEvent(signal)
    }
  }
}
</script>

<style scoped>
</style>
