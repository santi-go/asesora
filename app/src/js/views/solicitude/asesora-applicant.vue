<template>
  <div>
    <div class="card-title">
			<h3>{{ labels.applicant }}</h3>
		</div>
    <asesora-applicant-name :values="values"
                            :labels="labels"
                            :editionmode="editionmode"
                            ></asesora-applicant-name>
    <asesora-applicant-surname :values="values"
                               :labels="labels"
                               :editionmode="editionmode"
                               ></asesora-applicant-surname>
    <asesora-applicant-contact :values="values"
                               :labels="labels"
                               :editionmode="editionmode"
                               :is-valid-contact="isValidContact"
                               ></asesora-applicant-contact>
  </div>
</template>

<script>
import ApplicantNameView from './applicant/asesora-applicant-name'
import ApplicantSurnameView from './applicant/asesora-applicant-surname'
import ApplicantContactView from './applicant/asesora-applicant-contact'

export default {
  name: 'asesora-applicant',

  props: ['labels', 'values', 'isValidContact', 'editionmode'],

  components: {
    "asesora-applicant-name" : ApplicantNameView,
    "asesora-applicant-surname" : ApplicantSurnameView,
    "asesora-applicant-contact" : ApplicantContactView
  },
}
</script>

<style scoped>
  .card-title {
    padding: 15px 0px;
  }
</style>
