<template>
  <div>
    <div class="card-title">
			<h3>{{ labels.applicant }}</h3>
		</div>
    <asesora-applicant-name :values="values" :labels="labels"></asesora-applicant-name>
    <asesora-applicant-surname :values="values" :labels="labels"></asesora-applicant-surname>
    <asesora-applicant-contact :values="values" :labels="labels"></asesora-applicant-contact>
  </div>
</template>

<script>
import ApplicantNameView from './applicant/asesora-applicant-name'
import ApplicantSurnameView from './applicant/asesora-applicant-surname'
import ApplicantContactView from './applicant/asesora-applicant-contact'

export default {
  name: 'asesora-applicant',

  props: ['labels', 'values'],

  components: {
    "asesora-applicant-name" : ApplicantNameView,
    "asesora-applicant-surname" : ApplicantSurnameView,
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
  .card-title {
    padding: 15px 0px;
  }
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
