<template>
  <div>
    <asesora-applicant :values="values" :labels="labels"></asesora-applicant>
    <asesora-date :values="values" :labels="labels" :editionmode="editionmode"></asesora-date>
    <asesora-text :values="values" :labels="labels"></asesora-text>
    <asesora-button :values="values" :labels="labels"></asesora-button>
    <asesora-button-discard :labels="labels"></asesora-button-discard>


    <div class="message-sent alert background-success">
      <em class="fa fa-thumbs-up"></em>
      Todo Ok! Enviando!
    </div>
  </div>
</template>

<script>
import DateView from './asesora-date'
import ApplicantView from './asesora-applicant'
import TextView from './asesora-text'
import ButtonView from './asesora-button'
import ButtonDiscardView from './asesora-button-discard'


export default {
  name: 'asesora-solicitudes-edition',

  props: ['labels', 'values', 'fullfilled', 'editionmode'],

  components: {
    "asesora-date" : DateView,
    "asesora-applicant" : ApplicantView,
    "asesora-text" : TextView,
    "asesora-button" : ButtonView,
    "asesora-button-discard" : ButtonDiscardView
  },

  mounted: function() {
    this.$on('discardCard', function(){
      this.discardCard()
    }.bind(this))
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

    discardCard(){
      this.$parent.$emit('discardCard');
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
  .message-sent {
    margin-bottom: 0;
    margin-top: 1em;
    display: none;
  }
  .button-inline {
    display: inline-block;
    margin-right: 1em;
  }
</style>
