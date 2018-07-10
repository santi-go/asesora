<template>
<div>
  <div class="row grid-resposive">
    <div class="column column-25">
      <label>{{ labels.applicant}}</label>
      <p><em>{{ labels.applicantName }}:</em> {{ values.applicantName }}</p>
      <p><em>{{ labels.applicantSurname }}:</em> {{ values.applicantSurname }}</p>
      <p><em>{{ labels.applicantCcaa }}:</em> {{ values.applicantCcaa.text }}</p>
      <p><em>{{ labels.applicantEmail }}:</em> {{ values.applicantEmail }}</p>
      <p><em>{{ labels.applicantPhonenumber }}:</em> {{ values.applicantPhonenumber }}</p>
      <p><em>{{ labels.date }}:</em> {{ values.date }}</p>
    </div>
    <div class="column column-25">
      <label>{{ labels.company}}</label>
      <p><em>{{ labels.companyName }}:</em> {{ values.companyName }}</p>
      <p><em>{{ labels.companyCif }}:</em> {{ values.companyCif }}</p>
      <p><em>{{ labels.companyEmployees }}:</em> {{ values.companyEmployees }}</p>
      <p><em>{{ labels.companyCnae }}:</em> {{ values.companyCnae }}</p>
    </div>
    <div id="text"class="column column-50">
      <label> {{ labels.text }}:</label>
      <p>{{ values.text }}</p>
    </div>
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

#text {
  overflow: hidden;
}

label {
  margin-bottom: 1em;
  margin-left: 1em;
}

p em {
  margin-left: 0.5rem;
  margin-right: 0.5rem;
  font-size: 0.9em;
}

/*p {
  overflow-y: scroll;
}*/



</style>
