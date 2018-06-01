<template>
  <div class="button-inline">
    <button  id="save-company"
              type="button"
              name="submit"
              class="submitbutton"
              :disabled="!saveCompany"
              v-on:click="save()">
              {{ labels.editionsubmit }}
  </button>
</div>
</template>

<script>
export default {
  name: 'asesora-company-save-button',

  props: ['labels', 'values', 'saveCompany'],

  methods: {
    save(){
      let signal = new CustomEvent('clicked.save.company',
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

<style scoped>
</style>
