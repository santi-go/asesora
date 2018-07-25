<template>
  <div class="button-inline">
    <button  id="modify-counseling"
            type="button"
            name="submit"
            class="submitbutton"
            :title="showWarningIfNotJustifiable()"
            :disabled="!submittable"
            v-on:click="modifyCounseling()">
            {{ labels.modifySubject }}
            <label  v-if="warningSubject"
                    class="fa fa-warning">
            </label>
    </button>
  </div>
</template>

<script>
export default {
  name: 'asesora-button-modify-counseling',

  props: ['labels', 'values', 'submittable', 'warningSubject'],

  methods: {
    showWarningIfNotJustifiable(){
      if(this.warningSubject){
        return this.labels.notJustifiable
      }
      return ""
    },

    modifyCounseling(event) {
    let signal = new CustomEvent('clicked.modify.counseling',
                                  {'detail': {
                                    subjectId: this.values.subjectId,
                                    solicitudeId: this.values.id,
                                    proposals: this.values.proposals,
                                    description: this.values.description,
                                    analysis: this.values.analysis,
                                    topics: this.values.selectedTopics,
                                    comments: this.values.comments,
                                    reason: this.values.reason,
                                    closed: this.values.closed
                                  },
                                  'bubbles': true})
      this.$el.dispatchEvent(signal)
    }
  }
}
</script>

<style scoped>
</style>
