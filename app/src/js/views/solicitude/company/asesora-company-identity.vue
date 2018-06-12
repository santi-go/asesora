<template>
  <div>
    <asesora-company-name :values="values"
                          :labels="labels"
                          :edit-company="editCompany">
                          </asesora-company-name>

    <template v-if="editionmode && !editCompany">
      <div class="button-inline">
        <button id="add-value"
                type="button"
                name="add-value"
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
  </div>
</template>

<script>
import CompanyNameView from './asesora-company-name'
import CompanyCifView from './asesora-company-cif'

export default {
  name: 'asesora-company-identity',

  props: ['labels', 'values', 'isValidCif','isValidCompanyIdentity', 'editCompany', 'editionmode'],

  components: {
    "asesora-company-name" : CompanyNameView,
    "asesora-company-cif" : CompanyCifView,
  },

  methods: {
    addValueName(){
      let signal = new CustomEvent('clicked.add.value.name.to.company',
                                  {'detail': {},
                                  'bubbles': true})
      this.$el.dispatchEvent(signal)

    }
  }
}
</script>
