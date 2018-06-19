<template>
  <div>
    <asesora-company-name :values="values"
                          :labels="labels"
                          :edit-company="editCompany">
                          </asesora-company-name>
      <div id="company-identity-info" v-if="!isValidCompanyName">
        <div class="alert background-danger">
          <em class="fa fa-times-circle"></em>
            {{ labels.noCompanyName }}
        </div>
      </div>
    <template v-if="showUpdatedNameValueMessage">
    <div id="added-name-value-message">
      <em>{{labels.addedNameValueMessage}}</em>
    </div>
    </template>


    <template v-if="editionmode && !editCompany">
      <div class="button-inline">
        <button id="add-name-value"
                type="button"
                name="add-name-value"
                class="submitbutton"
                v-on:click="addValueName()">
        {{ labels.addValue }}</button>
      </div>
    </template>


    <asesora-company-cif :values="values"
                         :labels="labels"
                         :edit-company="editCompany"
                         :is-valid-cif="isValidCif">
                         </asesora-company-cif>

    <div id="company-identity-info" v-if="!isValidCompanyIdentity">
      <div class="alert background-danger">
        <em class="fa fa-times-circle"></em>
         {{ labels.incompleteCompanyIdentity }}
      </div>
    </div>
    <em>{{ labels.companyInfo }}</em>
  </div>
</template>

<script>
import CompanyNameView from './asesora-company-name'
import CompanyCifView from './asesora-company-cif'

export default {
  name: 'asesora-company-identity',

  props: ['labels', 'values', 'isValidCif','isValidCompanyIdentity', 'isValidCompanyName',
          'editCompany', 'editionmode', 'showUpdatedNameValueMessage'],

  components: {
    "asesora-company-name" : CompanyNameView,
    "asesora-company-cif" : CompanyCifView,
  },

  methods: {
    addValueName(){
      let signal = new CustomEvent('clicked.add.value.name.to.company',
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
