<template>
  <div class="button-inline">
    <button  id="discard-company"
            type="button"
            name="discard"
            class="discardbutton button-clear"
            v-on:click="discardCompany()">
      {{ labels.editiondiscard }}
    </button>
  </div>
</template>

<script>
export default {

  name: 'asesora-company-discard-button',

  props: ['labels'],

  methods: {
    discardCompany() {
      console.log("cambios descartados")
    },
  }
}
</script>

<style scoped>
</style>
