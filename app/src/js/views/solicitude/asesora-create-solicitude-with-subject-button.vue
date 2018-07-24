<template>
  <div class="button-inline">
    <button  id="submit-and-add-subject"
            type="button"
            name="submit-and-add-subject"
            class="submitbutton"
            :title="showWarningIfNotJustifiable()"
            :disabled="!submittable && !editCompany"
            v-on:click="submit()">
    <template v-if="!editionmode">{{ labels.submittoSubject }}</template>
    <template v-else>{{ labels.editionsubmittoSubject }}</template>
      <label  v-if="warning"
              class="fa fa-warning">
      </label>
    </button>
  </div>
</template>

<script>
export default {
  name: 'asesora-create-solicitude-with-subject-button',

  props: ['labels', 'values', 'editionmode', 'submittable', 'editCompany', 'warning'],

  watch: {
    editionmode: function(val, oldVal){
      let button = this.$el.querySelector('button')
      if (val == true){
        button.disabled = false
      }
    }
  },

  methods: {
    showWarningIfNotJustifiable(){
      if(this.warning){
        return this.labels.notJustifiable
      }
      return ""
    },

    submit(){
      let event = 'submit.solicitude.and.add.subject'
      if (this.editionmode) {
        event = 'edit.solicitude.and.add.subject'
      }

      let signal = new CustomEvent(event,
                                  {'detail': {},
                                  'bubbles': true})
      this.$el.dispatchEvent(signal)
      let button = this.$el.querySelector('button')
      button.innerText = this.labels.editionsubmitting
      button.disabled = true
    }
  }
}
</script>

<style scoped>
</style>
