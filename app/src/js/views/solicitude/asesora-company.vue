<template>
  <div  class="card large-card" >
    <h3>{{ labels.company }}</h3>
    <div class="row grid-responsive">
      <div class="column column-50">
        <asesora-company-identity :values="values"
                                  :labels="labels"
                                  :isValidCif="isValidCif"
                                  :editionmode="editionmode"
                                  :is-valid-company-identity="isValidCompanyIdentity"
                                  ></asesora-company-identity>
        <asesora-company-employees :values="values"
                                   :labels="labels"
                                   :editionmode="editionmode"
                                   ></asesora-company-employees>
        <asesora-company-cnae :values="values"
                              :labels="labels"
                              :editionmode="editionmode"
                              :cnae-catalog="cnaeCatalog"
                              ></asesora-company-cnae>
      </div>
      <div class="column column-50" id="company-matches">
        <asesora-company-matches :labels="labels" :suggested-companies="suggestedCompanies"></asesora-company-matches>
      </div>
    </div>
  </div>
</template>

<script>
import CompanyIdentityView from './company/asesora-company-identity'
import CompanyEmployeesView from './company/asesora-company-employees'
import CompanyCnaeView from './company/asesora-company-cnae'
import CompanyMatchesView from './company/asesora-company-matches'

export default {
  name: 'asesora-company',

  props: ['labels', 'values', 'isValidCif', 'cnaeCatalog', 'suggestedCompanies',
          'isValidCompanyIdentity', 'editionmode'],

  components: {
    "asesora-company-identity" : CompanyIdentityView,
    "asesora-company-employees" : CompanyEmployeesView,
    "asesora-company-cnae" : CompanyCnaeView,
    "asesora-company-matches" : CompanyMatchesView
  }
}
</script>

<style scoped>
  .card-title {
    padding: 15px 0px;
  }

  label {
    margin-top: 1em;
  }
</style>
