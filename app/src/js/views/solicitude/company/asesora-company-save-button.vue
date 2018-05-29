<template>
  <div class="button-inline">
    <button  id="save-company"
            type="button"
            name="submit"
            class="submitbutton"
            v-on:click="saveCompany()">
    {{ labels.editionsubmit }}
    </button>
  </div>
</template>

<script>
export default {
  name: 'asesora-company-save-button',

  props: ['labels'],

  methods: {
    saveCompany(){
      console.log("LLamada al evento de guardar empresa");
    }
  }
}
</script>

<style scoped>
</style>
