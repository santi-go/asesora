<template>
  <div>
    <div class="card-title">
			<h3>{{ labels.company }}</h3>
		</div>
    <asesora-company-name :values="values" :labels="labels"></asesora-company-name>
    <asesora-company-cif :values="values" :labels="labels"></asesora-company-cif>
    <asesora-company-employees :values="values" :labels="labels"></asesora-company-employees>
    <asesora-company-cnae :values="values" :labels="labels"></asesora-company-cnae>
    
  </div>
</template>

<script>
import CompanyNameView from './company/asesora-company-name'
import CompanyCifView from './company/asesora-company-cif'
import CompanyEmployeesView from './company/asesora-company-employees'
import CompanyCnaeView from './company/asesora-company-cnae'

export default {
  name: 'asesora-company',

  props: ['labels', 'values'],

  components: {
    "asesora-company-name" : CompanyNameView,
    "asesora-company-cif" : CompanyCifView,
    "asesora-company-employees" : CompanyEmployeesView,
    "asesora-company-cnae" : CompanyCnaeView
  },

  methods: {
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
</style>
