<template>
  <div class="card large-card">
    <div class="card-title">
      <h2>{{ labels.subjectsData}}</h2>
    </div>
    <asesora-summary-solicitude :labels="labels" :values="values"></asesora-summary-solicitude>
    <asesora-subjects-list :labels="labels" :values="values"></asesora-subjects-list>
    <subject-topics :labels="labels" :values="values" :topics-catalog="topicsCatalog" :submittable="submittable"></subject-topics>
    <asesora-analysis-for-solicitude :labels="labels" :values="values"></asesora-analysis-for-solicitude>
    <asesora-proposals-for-action :labels="labels" :values="values" :proposals-catalog="proposalsCatalog"></asesora-proposals-for-action>
    <asesora-proposals-description :labels="labels" :values="values"></asesora-proposals-description>
    <asesora-subject-reason :labels="labels" :values="values" :reasons-catalog="reasonsCatalog"></asesora-subject-reason>
    <asesora-subject-comments :labels="labels" :values="values"></asesora-subject-comments>

    <template>
      <asesora-button-create-counseling :labels="labels"
                                        :values="values"
                                        :submittable="submittable"
                                        >
      </asesora-button-create-counseling>
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
  import SummarySolicitudeView from './subjects/asesora-summary-solicitude'
  import SubjectsListView from './subjects/asesora-subjects-list'
  import ProposalsDescriptionView from './subjects/asesora-proposals-description'
  import SubjectCommentsView from './subjects/asesora-subject-comments'
  import SubjectReasonView from './subjects/asesora-subject-reason'

  export default {
    name: 'asesora-subjects',
    props: ['labels', 'values', 'topicsCatalog', 'submittable',
            'proposalsCatalog', 'editionSubject', 'editionmode',
            'reasonsCatalog'],

    components: {
      "asesora-proposals-for-action": ProposalsView,
      "asesora-analysis-for-solicitude": AnalysisView,
      "asesora-button-create-counseling": ButtonCreateCounseling,
      "asesora-button-discard-subject": ButtonDiscardSubjectView,
      "subject-topics": SubjectTopicsView,
      "asesora-summary-solicitude": SummarySolicitudeView,
      "asesora-subjects-list": SubjectsListView,
      "asesora-proposals-description": ProposalsDescriptionView,
      "asesora-subject-comments": SubjectCommentsView,
      "asesora-subject-reason": SubjectReasonView
    }
  }
</script>

<style scoped>

</style>
