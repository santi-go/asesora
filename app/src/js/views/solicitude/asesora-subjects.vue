<template>
    <div class="card large-card">
      <div class="card-title">
        <h4>{{ labels.subjectsData}}</h4>
      </div>
        <asesora-proposals-for-action :labels="labels" :values="values" :proposals-catalog="proposalsCatalog"></asesora-proposals-for-action>
        <asesora-analysis-for-solicitude :labels="labels" :values="values"></asesora-analysis-for-solicitude>
        <subject-topics :labels="labels" :values="values" :topics-catalog="topicsCatalog" :submittable="submittable"></subject-topics>
        <template v-if="!editionmode">
          <asesora-button-create-counseling :labels="labels"
                                            :values="values"
                                            :submittable="submittable"
                                            >
          </asesora-button-create-counseling>
        </template>
        <template v-else>
          <asesora-button-modify-counseling :labels="labels"
                                            :values="values"
                                            :submittable="submittable">
          </asesora-button-modify-counseling>
        </template>
        <asesora-button-discard-subject :labels="labels">
        </asesora-button-discard-subject>
    </div>
</template>
<script>
import ProposalsView from './subjects/asesora-proposals-for-action'
import AnalysisView from './subjects/asesora-analysis-for-solicitude'
import ButtonCreateCounseling from './subjects/asesora-button-create-counseling'
import ButtonDiscardSubjectView from './subjects/asesora-button-discard-subject'
import SubjectTopicsView from './subjects/subject-topics'
import ButtonModifyCounseling from './subjects/asesora-button-modify-counseling'

export default {
  name: 'asesora-subjects',
  props: ['labels', 'values', 'topicsCatalog', 'submittable',
          'proposalsCatalog', 'editionSubject', 'editionmode'],
  components: {
    "asesora-proposals-for-action" : ProposalsView,
    "asesora-analysis-for-solicitude" : AnalysisView,
    "asesora-button-create-counseling": ButtonCreateCounseling,
    "asesora-button-discard-subject" : ButtonDiscardSubjectView,
    "subject-topics": SubjectTopicsView,
    "asesora-button-modify-counseling": ButtonModifyCounseling
    }
  }
</script>
<style scoped>

</style>
