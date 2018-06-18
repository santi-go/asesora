<template>
    <div class="card large-card">
      <div class="card-title">
        <h4>Datos del caso</h4>
      </div>
        <asesora-cases-solicitude :labels="labels" :values="values"></asesora-cases-solicitude>
        <asesora-proposals-for-action :labels="labels" :values="values"></asesora-proposals-for-action>
        <asesora-analysis-for-solicitude :labels="labels" :values="values"></asesora-analysis-for-solicitude>
    </div>
</template>
<script>
import ProposalsView from './cases/asesora-proposals-for-action'
import AnalysisView from './cases/asesora-analysis-for-solicitude'
import DataSolicitudeView from './cases/asesora-cases-solicitude'

export default {

  name: 'asesora-show-solicitude',
  props: ['labels', 'values'],
  components: {
    "asesora-proposals-for-action" : ProposalsView,
    "asesora-analysis-for-solicitude" : AnalysisView,
    "asesora-cases-solicitude" : DataSolicitudeView
  }

}
</script>
<style scoped>
  .card-title {
    margin-left: 1rem;
  }
</style>
