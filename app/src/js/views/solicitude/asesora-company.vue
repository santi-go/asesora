<template>
  <div  class="card large-card" >
    <div class="row grid-responsive">
      <h3>{{ labels.company }}</h3>
    </div>
    <div class="row grid-responsive">
      <div class="column column-50">
        <asesora-company-identity :values="values"
                                  :labels="labels"
                                  :isValidCif="isValidCif"
                                  :edit-company="editCompany"
                                  :is-valid-company-identity="isValidCompanyIdentity"
                                  ></asesora-company-identity>
        <asesora-company-employees :values="values"
                                   :labels="labels"
                                   :edit-company="editCompany"
                                   ></asesora-company-employees>
        <asesora-company-cnae :values="values"
                              :labels="labels"
                              :edit-company="editCompany"
                              :cnae-catalog="cnaeCatalog"
                              ></asesora-company-cnae>
      </div>
      <div class="column column-50" id="company-matches">
        <asesora-company-matches :labels="labels" :suggested-companies="suggestedCompanies"></asesora-company-matches>

      </div>
    </div>
    <template v-if="editionmode">
      <div v-if="editCompany">
        <asesora-company-edit-button :labels="labels">
      </asesora-company-edit-button>
    </div>
    <div v-if="!editCompany">
      <div id="alert-edit-company" class="alert">
        <em class="fa fa-calendar"></em>
        {{ labels.editingCompany }}
      </div>
    </div>
  </template>
    <div v-if="editionmode">
      <div v-if="!editCompany">
        <asesora-company-save-button :labels="labels" :values="values" :save-company='saveCompany'>
        </asesora-company-save-button>
        <asesora-company-discard-button :labels="labels">
        </asesora-company-discard-button>
      </div>
    </div>
  </div>
</template>

<script>
import CompanyIdentityView from './company/asesora-company-identity'
import CompanyEmployeesView from './company/asesora-company-employees'
import CompanyCnaeView from './company/asesora-company-cnae'
import CompanyMatchesView from './company/asesora-company-matches'
import CompanyEditButton from './company/asesora-company-edit-button'
import CompanySaveButton from './company/asesora-company-save-button'
import CompanyDiscardButton from './company/asesora-company-discard-button'



export default {
  name: 'asesora-company',

  props: ['labels', 'values', 'isValidCif', 'cnaeCatalog', 'suggestedCompanies',
          'isValidCompanyIdentity', 'editionmode', 'saveCompany', 'editCompany', 'disabledTextAndDate'],

  components: {
    "asesora-company-identity" : CompanyIdentityView,
    "asesora-company-employees" : CompanyEmployeesView,
    "asesora-company-cnae" : CompanyCnaeView,
    "asesora-company-matches" : CompanyMatchesView,
    "asesora-company-edit-button" : CompanyEditButton,
    "asesora-company-save-button" : CompanySaveButton,
    "asesora-company-discard-button" : CompanyDiscardButton
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
