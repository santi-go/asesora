<template>
  <div>
    <asesora-applicant :values="values" :labels="labels"></asesora-applicant>
    <asesora-date :values="values" :labels="labels" :editionmode="editionmode"></asesora-date>
    <asesora-text :values="values" :labels="labels"></asesora-text>
    <asesora-button :values="values" :labels="labels"></asesora-button>


    <div class="message-sent alert background-success">
      <em class="fa fa-thumbs-up"></em>
      Guardando edición...
    </div>
  </div>
</template>

<script>
import DateView from '../views/asesora-date'
import ApplicantView from '../views/asesora-applicant'
import TextView from '../views/asesora-text'
import ButtonView from '../views/asesora-button'


export default {
  name: 'asesora-solicitudes-edition',

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

  mounted: function(){
    this.$nextTick(function (){
      this.disableButton(false)
    })
  },

  methods: {
    setButtonStatus(){
      let applicantIsEmpty = this.applicantIsEmpty()
      let textIsEmpty = this.textIsEmpty()
      let dateIsEmpty = this.dateIsEmpty()
      this.disableButton(true)

      if(this.editionmode == true) {
        if (applicantIsEmpty == false && textIsEmpty == false && dateIsEmpty == false)

        this.disableButton(false)
        }
    },

    applicantIsEmpty(){
      return (this.values.applicant == "")
    },

    textIsEmpty(){
      return (this.values.text == "")
    },

    dateIsEmpty(){
      return !this.values.date
    },

    disableButton(toggle){
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
</style>
