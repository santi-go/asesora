<template>
  <div>
    <asesora-company-name :values="values" :labels="labels"></asesora-company-name>
    <asesora-company-cif :values="values" :labels="labels" :validatedcif="validatedcif"></asesora-company-cif>
    <div id="company-identity-info" v-bind:class="{hide: validcompanyidentity}">
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

  props: ['labels', 'values', 'validatedcif','validcompanyidentity'],

  components: {
    "asesora-company-name" : CompanyNameView,
    "asesora-company-cif" : CompanyCifView,
  }
}
</script>

<style>
  .hide {
    display: none;
  }
</style>
