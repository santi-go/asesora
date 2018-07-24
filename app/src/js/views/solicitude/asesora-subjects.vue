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

    <template>
      <asesora-button-create-counseling :labels="labels"
                                        :values="values"
                                        :submittable="submittable"
                                        :warning-subject="warningSubject"
                                        >
      </asesora-button-create-counseling>

      <asesora-button-discard-subject :labels="labels">
      </asesora-button-discard-subject>
    </template>

    <template v-if="submittable">
      <button-subject-close-modal-open  :labels="labels"
                                        :values="values"
                                        :reasons-catalog="reasonsCatalog">
      </button-subject-close-modal-open>
    </template>
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
  import ButtonSubjectCloseModalOpen from './subjects/button-subject-close-modal-open'

  export default {
    name: 'asesora-subjects',
    props: ['labels', 'values', 'topicsCatalog', 'submittable',
            'proposalsCatalog', 'editionSubject', 'editionmode',
            'reasonsCatalog', 'warningSubject'],

    components: {
      "asesora-proposals-for-action": ProposalsView,
      "asesora-analysis-for-solicitude": AnalysisView,
      "asesora-button-create-counseling": ButtonCreateCounseling,
      "asesora-button-discard-subject": ButtonDiscardSubjectView,
      "subject-topics": SubjectTopicsView,
      "asesora-summary-solicitude": SummarySolicitudeView,
      "asesora-subjects-list": SubjectsListView,
      "asesora-proposals-description": ProposalsDescriptionView,
      "button-subject-close-modal-open": ButtonSubjectCloseModalOpen,
    }
  }
</script>

<style scoped>

</style>
