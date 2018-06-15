<template>
    <div class="card large-card">
      <asesora-proposals-for-action :labels="labels" :values="values"></asesora-proposals-for-action>
      <asesora-analysis-for-solicitude :labels="labels" :values="values"></asesora-analysis-for-solicitude>
    </div>
</template>
<script>
import ProposalsView from './cases/asesora-proposals-for-action'
import AnalysisView from './cases/asesora-analysis-for-solicitude'


export default {

  name: 'asesora-cases',
  props: ['labels', 'values'],
  components: {
    "asesora-proposals-for-action" : ProposalsView,
    "asesora-analysis-for-solicitude" : AnalysisView,
  }
}
</script>
<style scoped>
</style>
