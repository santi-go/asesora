<template>
  <div class="button-inline">
    <button  id="discard"
            type="button"
            name="discard"
            class="discardbutton button-clear"
            v-on:click="onclick()">
      {{ labels.discard }}
    </button>
  </div>
</template>

<script>
export default {

  name: 'asesora-button-discard',

  props: ['labels'],

  methods: {
    onclick() {
      this.$parent.$emit('discardCard');
    },
  }
}
</script>

<style scoped>
</style>
