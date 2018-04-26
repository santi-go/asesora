<template>
  <div>
    <asesora-company-name :values="values" :labels="labels"></asesora-company-name>
    <asesora-company-cif :values="values" :labels="labels"></asesora-company-cif>
    <div  id="company-identity-info" v-bind:class="{hide: mustBeHidden}">
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

  props: ['labels', 'values'],

  data(){
    return {
      isNameEmpty: true,
      isCifEmpty: true,
      mustBeHidden: true
    }
  },

  components: {
    "asesora-company-name" : CompanyNameView,
    "asesora-company-cif" : CompanyCifView,
  },
  methods: {
    setNameEmptyStatus(value){
        this.isNameEmpty = value
        this.setEnoughInfo()
    },

    setCifEmptyStatus(value){
        this.isCifEmpty = value
        this.setEnoughInfo()
    },

    setEnoughInfo(){
        if(this.isNameEmpty && this.isCifEmpty){
            this.mustBeHidden = true
        } else if(this.isNameEmpty || this.isCifEmpty){
            this.mustBeHidden = false
        } else {
            this.mustBeHidden = true
        }
    }
  }
}
</script>

<style>
  .hide {
    display: none;
  }
</style>
