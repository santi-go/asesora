<template>
  <div  class="card large-card" >
    <div class="card-title">
      <h2>{{ labels.company }}</h2>
    </div>
    <div class="row grid-responsive">
      <div class="column column-20 box">
        <div class="subtitle-container">
          <div class="subtitle-item">
            <div class="subtitle">
              {{ labels.identification }}
            </div>
            <div>
              {{ labels.companyInfo }}
            </div>
          </div>
        <div class="subtitle-item">
          <div class="subtitle">
            {{ labels.information }}
          </div>
        </div>
        </div>
      </div>
      <div class="column column-40 box">
        <asesora-company-identity :values="values"
                                  :labels="labels"
                                  :isValidCif="isValidCif"
                                  :editionmode="editionmode"
                                  :edit-company="editCompany"
                                  :show-updated-name-value-message='showUpdatedNameValueMessage'
                                  :is-valid-company-identity="isValidCompanyIdentity"
                                  :is-valid-company-name='isValidCompanyName'
                                  ></asesora-company-identity>
        <asesora-company-employees :values="values"
                                   :labels="labels"
                                   :edit-company="editCompany"
                                   ></asesora-company-employees>

        <template v-if="showUpdatedEmployeesValueMessage">
          <div id="added-employees-value-message">
            <em>{{labels.addedEmployeesValueMessage}}</em>
          </div>
        </template>

        <template v-if="editionmode && !editCompany">
          <div class="button-inline">
            <button id="add-employees-value"
                    type="button"
                    name="add-employees-value"
                    class="submitbutton"
                    v-on:click="addValueEmployees()">
            {{ labels.addValue }}</button>
          </div>
        </template>

        <asesora-company-cnae :values="values"
                              :company-cnae="values.companyCnae"
                              :labels="labels"
                              :edit-company="editCompany"
                              :cnae-catalog="cnaeCatalog"
                              ></asesora-company-cnae>
      </div>
      <div class="column column-40" id="company-matches">
        <asesora-company-matches :labels="labels" :suggested-companies="suggestedCompanies"></asesora-company-matches>

      </div>
    </div>
    <template v-if="editionmode || showEditCompanyButton">
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
        <asesora-company-discard-button :labels="labels" :save-company='saveCompany'>
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
          'isValidCompanyIdentity', 'isValidCompanyName', 'editionmode', 'saveCompany',
          'editCompany', 'showUpdatedEmployeesValueMessage',
          'showUpdatedNameValueMessage', 'showEditCompanyButton'],

  components: {
    "asesora-company-identity" : CompanyIdentityView,
    "asesora-company-employees" : CompanyEmployeesView,
    "asesora-company-cnae" : CompanyCnaeView,
    "asesora-company-matches" : CompanyMatchesView,
    "asesora-company-edit-button" : CompanyEditButton,
    "asesora-company-save-button" : CompanySaveButton,
    "asesora-company-discard-button" : CompanyDiscardButton
  },

  methods: {
    addValueEmployees(){
      let signal = new CustomEvent('clicked.add.value.employees.to.company',
                                  {'detail': {
                                    'companyName': this.values.companyName,
                                    'companyCif': this.values.companyCif,
                                    'companyEmployees': this.values.companyEmployees,
                                    'companyCnae': this.values.companyCnae
                                    },
                                  'bubbles': true})
      this.$el.dispatchEvent(signal)

    }
  }

}
</script>
