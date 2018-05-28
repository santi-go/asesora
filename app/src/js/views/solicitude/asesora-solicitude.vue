<template>
  <div>
    <asesora-applicant :values="values"
                       :labels="labels"
                       :editionmode="editionmode"
                       :is-valid-contact="isValidContact"
                       :suggested-applicants='suggestedApplicants'
                       ></asesora-applicant>

    <div  class="card large-card" >
    <asesora-date :values="values"
                  :labels="labels"
                  :editionmode="editionmode"
                  :edit-company='editCompany'
                  ></asesora-date>
    <asesora-text :values="values"
                  :labels="labels"
                  :editionmode="editionmode"
                  :edit-company='editCompany'
                  ></asesora-text>
    </div>
    <asesora-company :values="values"
                     :labels="labels"
                     :suggested-companies="suggestedCompanies"
                     :is-valid-cif="isValidCif"
                     :cnae-catalog="cnaeCatalog"
                     :editionmode="editionmode"
                     :edit-company='editCompany'
                     :is-valid-company-identity="isValidCompanyIdentity"
                     ></asesora-company>
    <div  class="card large-card" >
    <asesora-button :values="values"
                    :labels="labels"
                    :editionmode="editionmode"
                    :submittable="submittable"
                    :edit-company='editCompany'
                    ></asesora-button>
    <template v-if="editionmode">
      <asesora-button-discard :labels="labels"></asesora-button-discard>
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
import ButtonDiscardView from './asesora-button-discard'

export default {
  name: 'asesora-solicitude',

  props: ['labels', 'values', 'fullfilled', 'editionmode', 'isValidCif',
          'cnaeCatalog', 'suggestedCompanies', 'isValidCompanyIdentity',
          'submittable', 'isValidContact', 'suggestedApplicants', 'editCompany'],

  components: {
    "asesora-date" : DateView,
    "asesora-applicant" : ApplicantView,
    "asesora-text" : TextView,
    "asesora-company" : CompanyView,
    "asesora-button" : ButtonView,
    "asesora-button-discard" : ButtonDiscardView
  },

  watch: {
    fullfilled: function(val, oldVal){
      if (val == true){
        this.animateCard()
      }
    }
  },

  methods: {

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
  input::placeholder {
    text-align: right;
    font-size: 32px;
    color: var(--error-color);
    line-height: 1.4em;
  }
  input::-webkit-input-placeholder {
    position: relative;
    top: 12px;
  }
  .error {
    border: 1px solid var(--error-color) !important;
  }
  textarea{
    min-height: 200px;
    width: 100%;
  }
  textarea::placeholder {
    text-align: right;
    font-size: 32px;
    color: var(--error-color);
  }

  .message-sent, .message-error {
    margin-bottom: 0;
    margin-top: 1em;
    display: none;
  }

</style>
