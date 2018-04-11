<template>
  <div>
    <label>{{ labels.text }}</label>
    <textarea rows="8"
              cols="8"
              placeholder="*"
              v-bind:class="{invalidBox: invalid}"
              v-on:blur="onBlur"
              v-on:focus="onFocus"
              v-model="values.text">
    </textarea>
  </div>
</template>
<script>
export default {
  name: 'asesora-solicitude-text',
  props: ['labels',
          'invalid',
          'values'],
  methods: {
    onBlur() {
      this.invalid = false
      if(this.values.text == "") {
        this.invalid = true
      }
    },
    onFocus() {
      this.invalid = false
    }
  }
}
</script>
<style scoped>
.invalidBox {
  border: 1px solid red !important;
}

textarea::placeholder {
  text-align: right;
  font-size: 2em;
  color: red;
}

</style>
