<template>
  <div class="button-inline">
    <button  id="submit"
            type="button"
            name="submit"
            class="submitbutton"
            :title="showWarningIfNotJustifiable()"
            :disabled="!submittable && !editCompany"
            v-on:click="submit()">
    <template v-if="!editionmode">{{ labels.submit }}</template>
    <template v-else>{{ labels.editionsubmit }}</template>
      <label  v-if="warning"
              class="fa fa-warning">
      </label>
    </button>
  </div>
</template>

<script>
export default {
  name: 'asesora-button',

  props: ['labels', 'values', 'editionmode', 'submittable', 'editCompany', 'warning'],


  methods: {
    showWarningIfNotJustifiable(){
      if(this.warning){
        return this.labels.notJustifiable
      }
      return ""
    },

    submit(){
      let event = 'submit.solicitude'
      if (this.editionmode) {
        event = 'edit.solicitude'
      }

      let signal = new CustomEvent(event,
                                  {'detail': {},
                                  'bubbles': true})
      this.$el.dispatchEvent(signal)
      let button = this.$el.querySelector('button')
      button.innerText = this.labels.editionsubmitting
      this.submittable = false
    }
  }
}
</script>

<style scoped>
</style>
