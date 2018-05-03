<template>
  <div>
    <label>{{ labels.phonenumber }}:</label>
    <input  id="phonenumber"
            name="phonenumber"
            type="text"
            v-on:focus="onFocus"
            v-on:keydown="keydown"
            v-on:blur="blur"
            v-model="values.phonenumber"
            >
  </div>
</template>

<script>
export default {
  name: 'asesora-phone',

  props: ['labels', 'values'],
  data: { function () {
      commandKey: false
    }
  },

  methods: {
    onFocus(event){
      event.target.classList.remove("error")
    },

    keydown(event){
      let cmdKeyMac = 91
      if (event.keyCode == cmdKeyMac){
        this.commandKey = true
      }
      if(!event.ctrlKey && this.commandKey != true){
        if (!this.isValidKeyCode(event.keyCode)){
          event.preventDefault()
        }
      }
      if (event.keyCode != cmdKeyMac){
        this.commandKey = false
      }
    },

    blur(event){
      let valid = this.phoneValidation()
      this.$parent.setValidPhonenumber(valid)
    },

    isArrowKeyCode(keycode){
      let isLeftArrow = keycode == 37
      let isArrowUp = keycode == 38
      let isRightArrow = keycode == 39
      let isArrowDown = keycode == 40

      return isLeftArrow || isRightArrow || isArrowDown || isArrowUp
    },

    isSeparatorKeyCode(keycode){
      let isSpaceBar = keycode == 32
      let isPeriod = keycode == 190 || keycode == 110
      let isHyphen = keycode == 189 || keycode == 109

      return isSpaceBar || isPeriod || isHyphen
    },

    isValidKeyCode(keycode){
      let isNumber = keycode >= 48 && keycode <= 57
      let isNumericKey = keycode >= 96 && keycode <= 105
      let isBackSpace = keycode == 8
      let isTab = keycode == 9
      let isSeparator = this.isSeparatorKeyCode(keycode)
      let isArrow = this.isArrowKeyCode(keycode)

      return isNumber || isNumericKey || isSeparator || isTab || isBackSpace || isArrow
    },

    phoneValidation(){
      let field = this.$el.querySelector('#phonenumber')
      let phoneNumber = this.phoneNumberfilter(field.value)

      field.classList.remove("error")
      if(phoneNumber == ""){
        return false
      }else if(phoneNumber.length != 9 ){
        field.classList.add("error")
        return false
      }
      field.value = phoneNumber
      return true
    },

    phoneNumberfilter(rawPhoneNumber) {
      let splitNumber = rawPhoneNumber.split("");
      let phoneNumber = splitNumber.filter(function(item){
          return item != "-" && item != " " & item != "."
      }).join("")
      return phoneNumber
    }
  }
}
</script>

<style scoped>
  .error {
    border: 1px solid var(--error-color) !important;
  }
</style>
