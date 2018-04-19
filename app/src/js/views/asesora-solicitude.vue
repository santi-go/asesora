<template>
  <div>
    <asesora-applicant :values="values" :labels="labels"></asesora-applicant>
    <asesora-date :values="values" :labels="labels" :editionmode="editionmode"></asesora-date>
    <asesora-text :values="values" :labels="labels"></asesora-text>
    <asesora-button :values="values" :labels="labels"></asesora-button>
    <div class="message-sent alert background-success">
      <em class="fa fa-thumbs-up"></em>
      Todo Ok! Enviando!
    </div>
  </div>
</template>

<script>
import DateView from '../views/asesora-date'
import ApplicantView from '../views/asesora-applicant'
import TextView from '../views/asesora-text'
import ButtonView from '../views/asesora-button'


export default {
  name: 'asesora-solicitude',

  props: ['labels', 'values', 'fullfilled', 'editionmode'],

  components: {
    "asesora-date" : DateView,
    "asesora-applicant" : ApplicantView,
    "asesora-text" : TextView,
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
    enableButton(){
      let applicantIsEmpty = this.contentApplicant()
      let textIsEmpty = this.contentText()
      this.activateButton(true)
      if (applicantIsEmpty == true && textIsEmpty == true){
        this.activateButton(false)
      }
    },
    contentApplicant(){
      return !(this.values.applicant == "")
    },

    contentText(){
      return !(this.values.text == "")
    },

    activateButton(toggle){
      document.querySelector(".submitbutton").disabled = toggle
    },

    animateCard() {
      this.show()
      this.$parent.$emit('moveCard');
    },

    show() {
      let message = document.querySelector(".message-sent")
      message.style.display = 'block'
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
  .message-sent {
    margin-bottom: 0;
    margin-top: 1em;
    display: none;
  }
</style>
