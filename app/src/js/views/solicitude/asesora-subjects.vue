<template>
    <div class="card large-card">
      <div class="card-title">
        <h4>{{ labels.subjectsData}}</h4>
      </div>
        <asesora-proposals-for-action :labels="labels" :values="values" :proposals-catalog="proposalsCatalog"></asesora-proposals-for-action>
        <asesora-analysis-for-solicitude :labels="labels" :values="values"></asesora-analysis-for-solicitude>
        <subject-topics :labels="labels" :values="values" :topics-catalog="topicsCatalog"></subject-topics>
        <asesora-button-create-counseling :labels="labels" :values="values" :submittable="submittable"></asesora-button-create-counseling>
    </div>
</template>
<script>
import ProposalsView from './subjects/asesora-proposals-for-action'
import AnalysisView from './subjects/asesora-analysis-for-solicitude'
import ButtonCreateCounseling from './subjects/asesora-button-create-counseling'
import SubjectTopicsView from './subjects/subject-topics'

export default {

  name: 'asesora-subjects',
  props: ['labels', 'values', 'topicsCatalog', 'submittable', 'proposalsCatalog'],
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
