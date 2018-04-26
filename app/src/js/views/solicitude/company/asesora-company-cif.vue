<template>
  <div>
    <label>{{ labels.cif }}:</label>
    <input  id="cif"
            name="cif"
            placeholder="*"
            type="text"
            v-on:keyup="onKeyUp"
            v-on:focus="onFocus"
            v-on:keydown="keydown"
            v-on:blur="cifValidation"
            v-model="values.cif"
            >
  </div>
</template>

<script>
export default {
  name: 'asesora-company-cif',

  props: ['labels', 'values'],

  methods: {
    onKeyUp(event){
      event.target.className = ""
      if (event.target.value == "") {
        event.target.className = "error"
      }
    },

    onFocus(){
      event.target.className = ""
    },

    keydown(event){
      if(!event.ctrlKey){
        if (!this.isValidKeyCode(event.keyCode)){
          event.preventDefault()
        }
      }
    },

    isValidKeyCode(keycode){
      let isNumber = keycode >= 48 && keycode <= 57
      let isSpaceBar = keycode == 32
      let isPeriod = keycode == 190
      let isHyphen = keycode == 189
      let isTab = keycode == 9
      let isBackSpace = keycode == 8
      let isLeftArrow = keycode == 37
      let isRightArrow = keycode == 39

      return isNumber || isSpaceBar || isPeriod || isHyphen
             || isTab || isBackSpace || isLeftArrow || isRightArrow
    },

    cifValidation(event){
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
