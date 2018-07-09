<template>
<div>
  <div class="row grid-resposive">
    <div class="colum colum-50" id="colum">
      <label>{{ labels.applicant}}</label>
      <p><em>{{ labels.applicantName }}:</em> {{ values.applicantName }}</p>
      <p><em>{{ labels.applicantSurname }}:</em> {{ values.applicantSurname }}</p>
      <p><em>{{ labels.applicantCcaa }}:</em> {{ values.applicantCcaa.text }}</p>
      <p><em>{{ labels.applicantEmail }}:</em> {{ values.applicantEmail }}</p>
      <p><em>{{ labels.applicantPhonenumber }}:</em> {{ values.applicantPhonenumber }}</p>
      <p><em>{{ labels.date }}:</em> {{ values.date }}</p>
    </div>
    <div class="colum colum-50">
      <label>{{ labels.company}}</label>
      <p><em>{{ labels.companyName }}:</em> {{ values.companyName }}</p>
      <p><em>{{ labels.companyCif }}:</em> {{ values.companyCif }}</p>
      <p><em>{{ labels.companyEmployees }}:</em> {{ values.companyEmployees }}</p>
      <p><em>{{ labels.companyCnae }}:</em> {{ values.companyCnae }}</p>
    </div>
  </div>
  <div>
    <label> {{ labels.text }}:</label>
    <p><em>{{ values.text }}</em></p>
  </div>
</div>
</template>

<script>
export default {
  name: 'asesora-summary-solicitude',

  props: ['labels', 'values'],

}
</script>
<style scoped>
label {
  margin-bottom: 1rem;
  margin-left: 1rem;
}

#colum {
  margin-left: 1rem;
  margin-right: 20rem;
}

p {
  margin-left: 1rem;
}

</style>
