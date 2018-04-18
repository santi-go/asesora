<template>
  <div>
    <label>{{ labels.applicant }}:</label>
    <input  id="applicant"
            name="applicant"
            placeholder="*"
            type="text"
            v-on:blur="onBlur"
            v-on:focus="onFocus"
            v-model="values.applicant"
            >
  </div>
</template>

<script>
export default {

  props: ['labels', 'values'],

  methods: {
    onBlur(event){
      event.target.className = ""
      if (event.target.value == "") {
        event.target.className = "error"
      }
      this.$parent.enableButton()
    },

    onFocus(){
      event.target.className = ""
    }
  }
}
</script>

<style scoped>

  input::placeholder {
    text-align: right;
    font-size: 2em;
    color: var(--error-color);
    line-height: 1.4em;
  }
  input::-webkit-input-placeholder {
    position: relative;
    top: 12px;
  }
  .error {
    border: 1px solid var(--error-color) !important;
  }
</style>
