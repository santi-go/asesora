<template>
  <div>
    <asesora-company-name :values="values" :labels="labels"></asesora-company-name>
    <asesora-company-cif :values="values" :labels="labels" :validatedcif="validatedcif"></asesora-company-cif>
    <div  id="company-identity-info" v-bind:class="{hide: validIdentity}">
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

  props: ['labels', 'values', 'validatedcif'],

  data(){
    return {
      isNameEmpty: true,
      isCifEmpty: true,
      validIdentity: true
    }
  },

  components: {
    "asesora-company-name" : CompanyNameView,
    "asesora-company-cif" : CompanyCifView,
  },

  methods: {
    setNameEmptyStatus(value){
        this.isNameEmpty = value
        this.setValidInfo()
    },

    setCifEmptyStatus(value){
        this.isCifEmpty = value
        this.setValidInfo()
    },

    setValidInfo(){
        if(this.isNameEmpty && this.isCifEmpty){
            this.validIdentity = true
        } else if(this.isNameEmpty || this.isCifEmpty){
            this.validIdentity = false
        } else {
            this.validIdentity = true
        }
        this.$parent.$parent.setCompanyIdentityStatus(this.validIdentity)
    }
  }
}
</script>

<style>
  .hide {
    display: none;
  }
</style>
