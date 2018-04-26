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

  methods: {
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

    blur(){
      let valid = this.phoneValidation()
      this.$parent.setValidPhonenumber(valid)
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

    phoneValidation(){
      let field = this.$el.querySelector('#phonenumber')
      let phoneNumber = field.value
      field.className = ""
      if(phoneNumber == ""){
        return false
      }else if(phoneNumber.length != 9){
        field.className = "error"
        return false
      }
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
