<template>
  <div class="button-inline">
    <button  id="create-counseling"
            type="button"
            name="submit"
            class="submitbutton"
            :disabled="!submittable"
            v-on:click="createCounseling()">
            {{ labels.createSubject }}
    </button>
  </div>
</template>

<script>
export default {
  name: 'asesora-button-create-counseling',

  props: ['labels', 'values', 'submittable'],

  methods: {
    createCounseling() {
    let signal = new CustomEvent('clicked.create.counseling',
                                  {'detail': {
                                    solicitudeId: this.values.solicitudeId,
                                    proposals: this.values.proposals,
                                    analysis: this.values.analysis,
                                    description: this.values.description,
                                    topics: this.values.selectedTopics,
                                  },
                                  'bubbles': true})
      this.$el.dispatchEvent(signal)
    }
  }
}
</script>

<style scoped>
</style>
