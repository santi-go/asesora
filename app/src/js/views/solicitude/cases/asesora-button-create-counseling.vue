<template>
  <div class="button-inline">
    <button  id="create-counseling"
            type="button"
            name="submit"
            class="submitbutton"
            v-on:click="createCounseling()">
            {{ labels.createSubject }}
    </button>
  </div>
</template>

<script>
export default {
  name: 'asesora-button-create-counseling',

  props: ['labels', 'values'],

  methods: {
    createCounseling() {
    console.log(this.values.solicitudeId);  
    let signal = new CustomEvent('clicked.create.counseling',
                                  {'detail': {
                                    solicitudeId: this.values.solicitudeId,
                                    proposal: this.values.proposals,
                                    analysis: this.values.analysis,
                                    topics:[]
                                  },
                                  'bubbles': true})
      this.$el.dispatchEvent(signal)
    }
  }
}
</script>

<style scoped>
</style>
