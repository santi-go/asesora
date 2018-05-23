<template>
  <div>
    <div class="card-title">
			<h3>{{ labels.applicant }}</h3>
		</div>
    <div class="row grid-responsive">
      <div class="column column-50">
        <asesora-applicant-name :values="values"
                                :labels="labels"
                                :editionmode="editionmode">
        </asesora-applicant-name>

        <asesora-applicant-surname :values="values"
                                   :labels="labels"
                                   :editionmode="editionmode">
        </asesora-applicant-surname>

        <asesora-applicant-contact :values="values"
                                   :labels="labels"
                                   :editionmode="editionmode"
                                   :is-valid-contact="isValidContact">
        </asesora-applicant-contact>
      </div>

      <div class="column column-50" id="applicant-matches">
        <asesora-applicant-matches :values="values"
                                   :labels="labels"
                                   :suggested-applicants='suggestedApplicants'>
        </asesora-applicant-matches>
      </div>  
    </div>
  </div>
</template>

<script>
import ApplicantNameView from './applicant/asesora-applicant-name'
import ApplicantSurnameView from './applicant/asesora-applicant-surname'
import ApplicantContactView from './applicant/asesora-applicant-contact'
import ApplicantMatchesView from './applicant/asesora-applicant-matches'

export default {
  name: 'asesora-applicant',

  props: ['labels', 'values', 'isValidContact', 'editionmode', 'suggestedApplicants'],

  components: {
    "asesora-applicant-name" : ApplicantNameView,
    "asesora-applicant-surname" : ApplicantSurnameView,
    "asesora-applicant-contact" : ApplicantContactView,
    "asesora-applicant-matches" : ApplicantMatchesView
  },
}
</script>

<style scoped>
  .card-title {
    padding: 15px 0px;
  }

  label {
    margin-top: 1em;
  }
</style>
