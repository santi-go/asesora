<template>
  <div  class="card large-card" >
    <div class="card-title">
      <h2>{{ labels.applicant }}</h2>
    </div>
    <div class="row grid-responsive">
      <div class="column column-20 box">
        <div class="subtitle-container">
          <div class="subtitle-item">
            <div class="subtitle">{{ labels.personalData }}</div>
          </div>
          <div class="subtitle-item">
            <div class="subtitle">{{ labels.contactData }}<span>*</span></div>
            <div>
              {{ labels.noContact }}
            </div>
          </div>
        </div>
      </div>
      <div class="column column-40 box">
        <div>
          <label for="name">{{ labels.applicantName }}</label>
          <input  id="name"
          name="name"
          type="text"
          v-on:keyup="refreshSuggestion"
          v-model="values.applicantName"
          >
        </div>
        <div>
          <label for="surname">{{ labels.applicantSurname }}</label>
          <input  id="surname"
          name="surname"
          type="text"
          v-on:keyup="refreshSuggestion"
          v-model="values.applicantSurname"
          >
        </div>
        <asesora-applicant-ccaa :labels="labels"
                                :values="values"
                                :ccaa-catalog="ccaaCatalog">
        </asesora-applicant-ccaa>
        <asesora-applicant-contact :values="values"
        :editionmode="editionmode"
        :labels="labels"
        :is-valid-contact="isValidContact"
        :is-valid-phone="isValidPhone"
        :is-valid-email='isValidEmail'>
      </asesora-applicant-contact>
    </div>

    <div class="column column-40" id="applicant-matches">
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
import ApplicantCCAAView from './applicant/asesora-applicant-ccaa'


export default {
  name: 'asesora-applicant',

  props: ['labels', 'values', 'editionmode', 'isValidContact', 'suggestedApplicants', 'isValidPhone', 'isValidEmail', 'ccaaCatalog'],

  components: {
    "asesora-applicant-contact" : ApplicantContactView,
    "asesora-applicant-matches" : ApplicantMatchesView,
    "asesora-applicant-ccaa":ApplicantCCAAView
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
