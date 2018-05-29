<template>
  <div class="button-inline">
    <button id="edit-company"
            type="button"
            name="edit-company"
            class="submitbutton"
            v-on:click="edit()">
    {{ labels.editCompany }}</button>
  </div>
</template>

<script>
export default {
  name: 'asesora-button',

  props: ['labels'],

  methods: {
    edit(){
      let signal = new CustomEvent('clicked.edit.company',
                                  {'detail': {},
                                  'bubbles': true})
      this.$el.dispatchEvent(signal)
    }
  }
}
</script>

<style scoped>
</style>
