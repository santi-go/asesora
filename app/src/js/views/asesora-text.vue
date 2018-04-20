<template>
  <div>
    <label>{{ labels.text }}</label>
    <textarea id="solicitude-text"
              placeholder="*"
              v-on:blur="onBlur"
              v-on:focus="onFocus"
              v-model="values.text">
    </textarea>
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
      this.$parent.setButtonStatus()
    },

    onFocus(){
      event.target.className = ""
    }
  }
}
</script>

<style scoped>

  textarea{
    min-height: 200px;
    width: 100%;
  }
  textarea::placeholder {
    text-align: right;
    font-size: 2em;
    color: var(--error-color);
  }
  .error {
    border: 1px solid var(--error-color) !important;
  }
</style>
