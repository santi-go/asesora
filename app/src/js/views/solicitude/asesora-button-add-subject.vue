<template>
  <div class="button-inline">
    <button id='add-subject-button'
            type="button"
            name="button"
            v-on:click='addSubject()'>
            {{ labels.addSubject }}
    </button>
  </div>
</template>

<script>
export default {

  name: 'asesora-button-add-subject',

  props: ['labels', 'values', ],

  methods: {
    addSubject(){
      let signal = new CustomEvent('clicked.add.subject',
                                  {'detail': this.values.id,
                                  'bubbles': true})
      this.$el.dispatchEvent(signal)
    }
  }
}
</script>

<style scoped>
</style>
