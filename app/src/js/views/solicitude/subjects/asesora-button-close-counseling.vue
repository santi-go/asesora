<template>
  <div class="button-inline">
    <button  id="close-counseling"
            type="button"
            name="submit"
            class="submitbutton"
            :disabled="!submittable"
            v-on:click="closeCounseling()">
            {{labels.closeCounseling}}
    </button>
</div>
</template>

<script>
export default {
  name: 'asesora-button-close-counseling',

  props: ['labels', 'values', 'submittable'],

  methods: {
    closeCounseling(event) {
    let signal = new CustomEvent('clicked.close.counseling',
                                  {'detail': {
                                    subjectId: this.values.subjectId,
                                    solicitudeId: this.values.id,
                                    proposals: this.values.proposals,
                                    description: this.values.description,
                                    analysis: this.values.analysis,
                                    topics:this.values.selectedTopics,
                                    reasons: this.values.reasons,
                                    counseling_comment: this.values.counseling_comment
                                  },
                                  'bubbles': true})
      this.$el.dispatchEvent(signal)
    }
  }
}
</script>

<style scoped>
</style>
