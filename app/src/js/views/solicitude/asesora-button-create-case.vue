<template>
  <div class="button-inline">
    <button class='create-case-button'
            type="button"
            name="button"
            v-on:click='createCase()'>
            {{ labels.createCase }}
    </button>
  </div>
</template>

<script>
export default {

  name: 'asesora-button-create-case',

  props: ['labels', 'values'],

  methods: {
    createCase(){
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
