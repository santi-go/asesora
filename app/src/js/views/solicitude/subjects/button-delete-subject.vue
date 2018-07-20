<template>
  <div class="button-inline">
    <button  id="delete-subject"
      type="button"
      name="delete-subject"
      class="discardbutton button-clear"
      v-on:click="deleteSubject()">
    {{labels.deleteSubject}}
  </button>
</div>
</template>

<script>
export default {
  name: 'button-delete-subject',

  props: ['labels', 'values'],

  methods: {
    deleteSubject(event) {
    let signal = new CustomEvent('clicked.delete.subject',
                                  {'detail': {'subjectId': this.values.subjectId},
                                  'bubbles': true})
      this.$el.dispatchEvent(signal)
    }
  }
}
</script>

<style scoped>
#delete-subject{
  margin-left: -3rem;
}
</style>
