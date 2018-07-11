<template>
  <div id='subjects-edition'>
    <div>
      <asesora-proposals-for-action :labels="labels" :values="values" :proposals-catalog="proposalsCatalog"></asesora-proposals-for-action>
      <asesora-proposals-description :labels="labels" :values="values"></asesora-proposals-description>
      <asesora-analysis-for-solicitude :labels="labels" :values="values"></asesora-analysis-for-solicitude>
      <subject-topics :labels="labels" :values="values" :topics-catalog="topicsCatalog" :submittable="submittable"></subject-topics>
      <asesora-button-modify-counseling :labels="labels"
                                        :values="values"
                                        :submittable="submittable">
      </asesora-button-modify-counseling>
    </div>
  </div>
</template>

<script>
import ProposalsView from './asesora-proposals-for-action'
import AnalysisView from './asesora-analysis-for-solicitude'
import SubjectTopicsView from './subject-topics'
import ButtonModifyCounseling from './asesora-button-modify-counseling'
import ProposalsDescriptionView from './asesora-proposals-description'

  export default {
    name: 'asesora-subjects-list',
    props: ['labels', 'values', 'topicsCatalog', 'proposalsCatalog',
            'submittable'],
    components: {
      "asesora-proposals-for-action" : ProposalsView,
      "asesora-analysis-for-solicitude" : AnalysisView,
      "subject-topics": SubjectTopicsView,
      "asesora-button-modify-counseling": ButtonModifyCounseling,
      "asesora-proposals-description": ProposalsDescriptionView
    }
  }
</script>
