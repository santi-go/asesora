<template>
    <div class="card large-card">
      <div class="card-title">
        <h4>{{ labels.casesData}}</h4>
      </div>
        <asesora-proposals-for-action :labels="labels" :values="values"></asesora-proposals-for-action>
        <asesora-analysis-for-solicitude :labels="labels" :values="values"></asesora-analysis-for-solicitude>
        <subject-topics :labels="labels" :values="values" :topics-catalog="topicsCatalog"></subject-topics>
        <asesora-button-create-counseling :labels="labels" :values="values" :submittable="submittable"></asesora-button-create-counseling>
    </div>
</template>
<script>
import ProposalsView from './cases/asesora-proposals-for-action'
import AnalysisView from './cases/asesora-analysis-for-solicitude'
import ButtonCreateCounseling from './cases/asesora-button-create-counseling'
import SubjectTopicsView from './cases/subject-topics'

export default {

  name: 'asesora-cases',
  props: ['labels', 'values', 'topicsCatalog', 'submittable'],
  components: {
    "asesora-proposals-for-action" : ProposalsView,
    "asesora-analysis-for-solicitude" : AnalysisView,
    "asesora-button-create-counseling": ButtonCreateCounseling,
    "subject-topics": SubjectTopicsView
  }

}
</script>
<style scoped>

</style>
