<template>
  <div  class="card large-card" >
    <h3>{{ labels.applicant }}</h3>
    <div class="row grid-responsive">
      <div class="column column-50">
        <div>
          <label>{{ labels.applicantName }}</label>
          <input  id="name"
                  name="name"
                  type="text"
                  v-on:keyup="refreshSuggestion"
                  v-model="values.applicantName"
          >
        </div>
        <div>
          <label>{{ labels.applicantSurname }}</label>
          <input  id="surname"
                  name="surname"
                  type="text"
                  v-on:keyup="refreshSuggestion"
                  v-model="values.applicantSurname"
          >
        </div>

        <asesora-applicant-contact :values="values"
                                   :labels="labels"
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
import ApplicantContactView from './applicant/asesora-applicant-contact'
import ApplicantMatchesView from './applicant/asesora-applicant-matches'

export default {
  name: 'asesora-applicant',

  props: ['labels', 'values', 'isValidContact', 'suggestedApplicants'],

  components: {
    "asesora-applicant-contact" : ApplicantContactView,
    "asesora-applicant-matches" : ApplicantMatchesView
  },
  methods: {
    refreshSuggestion() {
      let signal = new CustomEvent('changed.applicant.fields',
                                      {'detail': {},
                                      'bubbles': true})
      this.$el.dispatchEvent(signal)
    }
  }
}
</script>
