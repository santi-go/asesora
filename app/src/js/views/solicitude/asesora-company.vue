<template>
  <div>
    <div class="card-title">
			<h3>{{ labels.company }}</h3>
		</div>
    <asesora-company-identity :values="values" :labels="labels" :validatedcif="validatedcif"
                              :duplicatedcompany ="duplicatedcompany"></asesora-company-identity>
    <asesora-company-employees :values="values" :labels="labels"></asesora-company-employees>
    <asesora-company-cnae :values="values" :labels="labels" :cnaecatalog="cnaecatalog"></asesora-company-cnae>

  </div>
</template>

<script>
import CompanyIdentityView from './company/asesora-company-identity'
import CompanyEmployeesView from './company/asesora-company-employees'
import CompanyCnaeView from './company/asesora-company-cnae'

export default {
  name: 'asesora-company',

  props: ['labels', 'values', 'validatedcif', 'cnaecatalog', 'duplicatedcompany'],

  components: {
    "asesora-company-identity" : CompanyIdentityView,
    "asesora-company-employees" : CompanyEmployeesView,
    "asesora-company-cnae" : CompanyCnaeView
  }
}
</script>

<style scoped>
  .card-title {
    padding: 15px 0px;
  }
</style>
