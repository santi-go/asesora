<template>
  <div>
    <asesora-applicant :values="values"
                       :labels="labels"
                       :editionmode="editionmode"
                       :is-valid-contact="isValidContact"
                       :suggested-applicants='suggestedApplicants'
                       :is-valid-phone="isValidPhone"
                       :is-valid-email="isValidEmail"
                       :ccaa-catalog="ccaaCatalog"
                       ></asesora-applicant>
    <div  class="card large-card" >
      <div class="card-title">
        <h2>{{ labels.solicitude }}</h2>
      </div>
      <div class="row grid-responsive">
      <div class="column column-20 box">
        <div class="subtitle-container">
          <div class="subtitle-item">
            <div class="subtitle">
              {{ labels.solicitudeData }}
            </div>
            <div <div id="date-info" v-if="!editionmode">
              {{ labels.noDate }}
            </div>
          </div>
        </div>
      </div>
    <div class="column column-80">
    <asesora-date :values="values"
                  :labels="labels"
                  :edit-solicitude='editSolicitude'
                  ></asesora-date>
    <asesora-text :values="values"
                  :labels="labels"
                  :edit-solicitude='editSolicitude'
                  ></asesora-text>
    </div>
    </div>
  </div>

    <asesora-company :values="values"
                     :labels="labels"
                     :suggested-companies="suggestedCompanies"
                     :is-valid-cif="isValidCif"
                     :cnae-catalog="cnaeCatalog"
                     :editionmode="editionmode"
                     :edit-company='editCompany'
                     :save-company='saveCompany'
                     :show-edit-company-button='showEditCompanyButton'

                     :show-updated-employees-value-message='showUpdatedEmployeesValueMessage'
                     :show-updated-name-value-message='showUpdatedNameValueMessage'
                     :is-valid-company-identity="isValidCompanyIdentity"
                     :is-valid-company-name='isValidCompanyName'
                     ></asesora-company>
    <template v-if="editionmode">
      <div  class="card large-card listed-subjects">
        <asesora-subjects-list  :labels="labels"
                                :values="values"
                                :topics-catalog="topicsCatalog"
                                :proposals-catalog="proposalsCatalog"
                                :submittable="submittable"
                                :edition-subject="editionSubject"
                                :editionmode="editionmode"
                                :modified-subject-id="modifiedSubjectId"
                                :reasons-catalog="reasonsCatalog">
        </asesora-subjects-list>
        <asesora-button-add-subject :labels="labels" :values="values"></asesora-button-add-subject>
      </div>
    </template>
    <div  class="card large-card" >
      <asesora-button :values="values"
                      :labels="labels"
                      :editionmode="editionmode"
                      :submittable="submittable"
                      :edit-company='editCompany'
                      ></asesora-button>
      <asesora-create-solicitude-with-subject-button
                      :values="values"
                      :labels="labels"
                      :editionmode="editionmode"
                      :submittable="submittable"
                      :edit-company='editCompany'
                      ></asesora-create-solicitude-with-subject-button>
      <template v-if="editionmode">
        <asesora-button-discard :labels="labels" :edit-company='editCompany' :submittable="submittable" ></asesora-button-discard>
        <asesora-button-delete :labels="labels" :values="values"></asesora-button-delete>
      </template>
    </div>

    <div class="alert background-success message-hidden ">
      <em class="fa fa-thumbs-up"></em>
      {{ labels.sent }}
    </div>

    <div class="message-sent alert background-success">
      <em class="fa fa-thumbs-up"></em>
      {{ labels.edited }}
    </div>
    <div class="message-error alert background-danger">
      <em class="fa fa-times-circle"></em>
      {{ labels.alertBackgroundDanger }}
    </div>
  </div>
</template>

<script>
import DateView from './asesora-date'
import ApplicantView from './asesora-applicant'
import TextView from './asesora-text'
import CompanyView from './asesora-company'
import ButtonView from './asesora-button'
import ButtonSolicitudeWithSubjectView from './asesora-create-solicitude-with-subject-button'
import ButtonDiscardView from './asesora-button-discard'
import ButtonDeleteView from './asesora-button-solicitude-delete'
import ButtonAddSubject from './asesora-button-add-subject'
import SubjectsListView from './subjects/asesora-subjects-list'

export default {
  name: 'asesora-solicitude',

  props: ['labels', 'values', 'fullfilled', 'fullfilledToAddSubject', 'editionmode', 'isValidCif',
          'cnaeCatalog', 'suggestedCompanies', 'isValidCompanyIdentity', 'isValidCompanyName',
          'submittable', 'isValidContact', 'suggestedApplicants', 'editCompany',
          'saveCompany', 'isValidPhone', 'isValidEmail',
          'showUpdatedEmployeesValueMessage', 'showUpdatedNameValueMessage', 'showEditCompanyButton',
          'topicsCatalog', 'proposalsCatalog', 'editionSubject', 'modifiedSubjectId',
          'ccaaCatalog', 'reasonsCatalog'],

  components: {
    "asesora-date" : DateView,
    "asesora-applicant" : ApplicantView,
    "asesora-text" : TextView,
    "asesora-company" : CompanyView,
    "asesora-button" : ButtonView,
    "asesora-create-solicitude-with-subject-button" : ButtonSolicitudeWithSubjectView,
    "asesora-button-discard" : ButtonDiscardView,
    "asesora-button-delete" : ButtonDeleteView,
    "asesora-button-add-subject": ButtonAddSubject,
    "asesora-subjects-list" : SubjectsListView
  },

  watch: {
    fullfilled: function(val, oldVal){
      if (val == true){
        this.animateCard()
      }
    },
    fullfilledToAddSubject: function(val, oldVal){
      if (val == true){
        this.hitToSubject()
      }
    }
  },

  methods: {

    hitToSubject() {
      this.show()
      let signal = new CustomEvent('fullfilled.solicitude.to.add.subject',
                                  {'detail': {},
                                  'bubbles': true})
      this.$el.dispatchEvent(signal)
    },

    animateCard() {
      this.show()
      let signal = new CustomEvent('fullfilled.solicitude',
                                  {'detail': {},
                                  'bubbles': true})
      this.$el.dispatchEvent(signal)
    },

    show() {
      let message = document.querySelector(".background-success")
      message.classList.remove("message-hidden")
      message.classList.add("messageSent")
    }
  }
}
</script>

<style scoped>

.message-sent, .message-error {
  margin-bottom: 0;
  margin-top: 1em;
  display: none;
}

</style>
