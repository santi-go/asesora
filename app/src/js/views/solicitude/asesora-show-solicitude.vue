<template>
    <div class="card large-card">
      <div class="card-title">
        <h4>{{ labels.summary }}</h4>
      </div>
        <asesora-summary-solicitude :labels="labels" :values="values"></asesora-summary-solicitude>

        <div  class="card large-card" >
          <div class="button-inline">
            <button   id='edit-button'
              type="button"
              name="button"
              v-on:click='solicitudeEdit()'>
              {{ labels.edit }}
            </button>
          </div>
          <div class="button-inline">
            <button  id='create-case-button'
              type="button"
              name="button"
              v-on:click='createCase()'>
              {{ labels.createCase }}
            </button>
          </div>
        </div>
    </div>
</template>
<script>
import ProposalsView from './cases/asesora-proposals-for-action'
import AnalysisView from './cases/asesora-analysis-for-solicitude'
import SummarySolicitudeView from './cases/asesora-summary-solicitude'

export default {

  name: 'asesora-show-solicitude',
  props: ['labels', 'values'],
  methods: {
    solicitudeEdit(){
      let signal = new CustomEvent('load.solicitude',
                                  {'detail': this.values.id,
                                  'bubbles': true})
      this.$el.dispatchEvent(signal)
    },

    createCase(){
      let signal = new CustomEvent('clicked.create.case',
                                  {'detail': this.values.id,
                                  'bubbles': true})
      this.$el.dispatchEvent(signal)
    }
  },
  components: {
    "asesora-proposals-for-action" : ProposalsView,
    "asesora-analysis-for-solicitude" : AnalysisView,
    "asesora-summary-solicitude" : SummarySolicitudeView
  }

}
</script>
<style scoped>
  .card-title {
    margin-left: 1rem;
  }
</style>
