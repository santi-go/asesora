<template>
  <div>
    <asesora-applicant :values="values" :labels="labels"></asesora-applicant>
    <asesora-date :values="values" :labels="labels" :editionmode="editionmode"></asesora-date>
    <asesora-text :values="values" :labels="labels"></asesora-text>
    <asesora-company :values="values"
                     :labels="labels"
                     :suggestedcompanies="suggestedcompanies"
                     :validatedcif="validatedcif"
                     :cnaecatalog="cnaecatalog"
                     :validcompanyidentity='validcompanyidentity'
                     ></asesora-company>
    <asesora-button :values="values" :labels="labels" :editionmode="editionmode"></asesora-button>
    <div class="alert background-success message-hidden ">
      <em class="fa fa-thumbs-up"></em>
      {{ labels.sent }}
    </div>
  </div>
</template>

<script>
import DateView from './asesora-date'
import ApplicantView from './asesora-applicant'
import TextView from './asesora-text'
import ButtonView from './asesora-button'
import CompanyView from './asesora-company'

export default {
  name: 'asesora-solicitude',

  props: ['labels', 'values', 'fullfilled', 'editionmode', 'validatedcif',
          'cnaecatalog', 'suggestedcompanies', 'validcompanyidentity'],

  data() {
    return {
      validContact: false,
    }
  },

  components: {
    "asesora-date" : DateView,
    "asesora-applicant" : ApplicantView,
    "asesora-text" : TextView,
    "asesora-company" : CompanyView,
    "asesora-button" : ButtonView
  },

  watch: {
    fullfilled: function(val, oldVal){
      if (val == true){
        this.animateCard()
      }
    }
  },

  methods: {
    setContactStatus(status){
      this.validContact = status
      this.setButtonStatus()
    },

    setCompanyIdentityStatus(status){
      this.validcompanyidentity = status
      this.setButtonStatus()
    },

    setButtonStatus(){
      this.disableButton(true)

      if (!this.textIsEmpty() && this.validContact && this.validcompanyidentity) {
        this.disableButton(false)
      }
    },

    applicantPhonenumberIsEmpty(){
      return (this.values.phonenumber == "")
    },

    applicantEmailIsEmpty(){
      return (this.values.email == "")
    },

    textIsEmpty(){
      return (this.values.text == "")
    },

    disableButton(toggle){
      document.querySelector(".submitbutton").disabled = toggle
    },

    animateCard() {
      this.show()
      this.$parent.$emit('moveCard');
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

</style>
