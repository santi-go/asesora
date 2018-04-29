<template>
  <div>
    <asesora-applicant :values="values" :labels="labels"></asesora-applicant>
    <asesora-date :values="values" :labels="labels" :editionmode="editionmode"></asesora-date>
    <asesora-text :values="values" :labels="labels"></asesora-text>
    <asesora-company :values="values" :labels="labels"></asesora-company>
    <asesora-button :values="values" :labels="labels" :editionmode="editionmode"></asesora-button>
    <asesora-button-discard :labels="labels"></asesora-button-discard>

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
import CompanyView from './asesora-company'
import TextView from './asesora-text'
import ButtonView from './asesora-button'
import ButtonDiscardView from './asesora-button-discard'


export default {
  name: 'asesora-solicitudes-edition',

  props: ['labels', 'values', 'fullfilled', 'errors', 'editionmode'],

  data() {
    return {
      validContact: true,
      validCompanyIdentity: true
    }
  },

  components: {
    "asesora-date" : DateView,
    "asesora-applicant" : ApplicantView,
    "asesora-company" : CompanyView,
    "asesora-text" : TextView,
    "asesora-button" : ButtonView,
    "asesora-button-discard" : ButtonDiscardView
  },

  mounted: function() {
    this.validContact = true

    this.$on('discardCard', function(){
      this.discardCard()
    }.bind(this))
  },

  watch: {
    fullfilled: function(val, oldVal){
      if (val == true){
        this.animateCard()
      }
    },
    errors: function(val, oldVal){
      if (val == true){
        this.animateErrorCard()
      }
      this.errors = false
    }
  },

  methods: {
    setContactStatus(status){
      this.validContact = status
      this.setButtonStatus()
    },

    setCompanyIdentityStatus(status){
      this.validCompanyIdentity = status
      this.setButtonStatus()
    },

    setButtonStatus(){
      this.disableButton(true)

      if (!this.textIsEmpty() && !this.dateIsEmpty() && this.validContact && this.validCompanyIdentity) {
        this.disableButton(false)
      }
    },

    textIsEmpty(){
      return (this.values.text == "")
    },

    dateIsEmpty(){
      return !this.values.date
    },

    discardCard(){
      this.$parent.$emit('discardCard');
    },

    disableButton(option){
      document.querySelector(".submitbutton").disabled = option
    },

    animateCard() {
      this.show()
      this.$parent.$emit('moveCard');
    },

    show() {
      let message = document.querySelector(".message-sent")
      message.style.display = 'block'
    },

    animateErrorCard() {
      this.showError()
      setTimeout(this.hideError, 3000)
    },

    showError() {
      let message = document.querySelector(".message-error")
      message.style.display = 'block'
    },

    hideError() {
      let message = document.querySelector(".message-error")
      message.style.display = 'none'
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
  .button-inline {
    display: inline-block;
    margin-right: 1em;
  }
</style>
