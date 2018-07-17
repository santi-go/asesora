<template>
  <div id='subjects-edition'>
    <div>
      <subject-topics :labels="labels" :values="values" :topics-catalog="topicsCatalog" :submittable="submittable"></subject-topics>
      <asesora-analysis-for-solicitude :labels="labels" :values="values"></asesora-analysis-for-solicitude>
      <asesora-proposals-for-action :labels="labels" :values="values" :proposals-catalog="proposalsCatalog"></asesora-proposals-for-action>
      <asesora-proposals-description :labels="labels" :values="values"></asesora-proposals-description>
      <asesora-subject-comments :labels="labels" :values="values"></asesora-subject-comments>
      <asesora-button-modify-counseling :labels="labels"
                                        :values="values"
                                        :submittable="submittable">
      </asesora-button-modify-counseling>

      <template v-if="this.values.closed == null">
        <asesora-button-close-counseling  :labels="labels"
                                          :values="values"
                                          :submittable="submittable">
        </asesora-button-close-counseling>
       </template>
       <template v-else> {{labels.closedSubject}}: {{this.values.closed}}</template>
    </div>
  </div>
</template>

<script>
import ProposalsView from './asesora-proposals-for-action'
import AnalysisView from './asesora-analysis-for-solicitude'
import SubjectTopicsView from './subject-topics'
import ButtonModifyCounseling from './asesora-button-modify-counseling'
import ButtonCloseCounseling from './asesora-button-close-counseling'
import ProposalsDescriptionView from './asesora-proposals-description'
import SubjectCommentsView from './asesora-subject-comments'

  export default {
    name: 'asesora-subjects-list',
    props: ['labels', 'values', 'topicsCatalog', 'proposalsCatalog',
            'submittable'],
    components: {
      "asesora-proposals-for-action" : ProposalsView,
      "asesora-analysis-for-solicitude" : AnalysisView,
      "subject-topics": SubjectTopicsView,
      "asesora-button-modify-counseling": ButtonModifyCounseling,
      "asesora-button-close-counseling": ButtonCloseCounseling,
      "asesora-proposals-description": ProposalsDescriptionView,
      "asesora-subject-comments": SubjectCommentsView
    }
  }
</script>
