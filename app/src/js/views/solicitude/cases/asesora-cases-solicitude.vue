<template>
<div>
  <div>
    <label>{{ labels.casesData }}</label>
  </div>
  <div class="row grid-resposive">
    <div class="colum colum-50" id="colum">
      <label>{{ labels.applicant}}</label>
      <p>{{ labels.applicantName }}: {{ values.applicantName }}</p>
      <p>{{ labels.applicantSurname }}: {{ values.applicantSurname }}</p>
      <p>{{ labels.applicantEmail }}: {{ values.applicantEmail }}</p>
      <p>{{ labels.applicantPhonenumber }}: {{ values.applicantPhonenumber }}</p>
      <p>{{ labels.date }}: {{ values.date }}</p>
    </div>
    <div class="colum colum-50">
      <label>{{ labels.company}}</label>
      <p>{{ labels.companyName }}: {{ values.companyName }}</p>
      <p>{{ labels.companyCif }}: {{ values.companyCif }}</p>
      <p>{{ labels.companyEmployees }}: {{ values.companyEmployees }}</p>
      <p>{{ labels.companyCnae }}: {{ values.companyCnae }}</p>
    </div>
  </div>
    <p>{{ labels.text }}:</p>
    <textarea disabled>{{ values.text }}</textarea>
</div>
</template>

<script>
export default {
  name: 'asesora-cases-solicitude',

  props: ['labels', 'values'],
  
}
</script>
<style scoped>
label {
  margin-bottom: 2rem;
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