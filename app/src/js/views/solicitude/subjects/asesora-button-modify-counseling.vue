<template>
  <div class="button-inline">
    <button  id="modify-counseling"
            type="button"
            name="submit"
            class="submitbutton"
            :disabled="!submittable"
            v-on:click="modifyCounseling()">
            {{ labels.modifySubject }}
    </button>
  </div>
</template>

<script>
export default {
  name: 'asesora-button-modify-counseling',

  props: ['labels', 'values', 'submittable'],

  methods: {
    modifyCounseling(event) {
    let signal = new CustomEvent('clicked.modify.counseling',
                                  {'detail': {
                                    subjectId: this.values.subjectId,
                                    proposals: this.values.proposals,
                                    analysis: this.values.analysis,
                                    topics:this.values.selectedTopics
                                  },
                                  'bubbles': true})
      this.$el.dispatchEvent(signal)
    }
  }
}
</script>

<style scoped>
</style>
