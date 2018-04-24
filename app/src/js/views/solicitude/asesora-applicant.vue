<template>
  <div>
    <label>{{ labels.applicant }}</label>

    <asesora-applicant-name :values="values" :labels="labels"></asesora-applicant-name>
    <asesora-applicant-secondname :values="values" :labels="labels"></asesora-applicant-secondname>
    <asesora-applicant-contact :values="values" :labels="labels"></asesora-applicant-contact>
  </div>
</template>

<script>
import ApplicantNameView from './applicant/asesora-applicant-name'
import ApplicantSecondnameView from './applicant/asesora-applicant-secondname'
import ApplicantContactView from './applicant/asesora-applicant-contact'

export default {
  name: 'asesora-applicant',

  props: ['labels', 'values'],

  components: {
    "asesora-applicant-name" : ApplicantNameView,
    "asesora-applicant-secondname" : ApplicantSecondnameView,
    "asesora-applicant-contact" : ApplicantContactView
  },

  methods: {
    onKeyUp(event){
      event.target.className = ""
      if (event.target.value == "") {
        event.target.className = "error"
      }
      this.$parent.setButtonStatus()
    },

    onFocus(){
      event.target.className = ""
    },

    keydown(event){
      if (event.keyCode == 13){
        event.preventDefault()
      }
    }
  }
}
</script>

<style scoped>

  input::placeholder {
    text-align: right;
    font-size: 2em;
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
</style>
