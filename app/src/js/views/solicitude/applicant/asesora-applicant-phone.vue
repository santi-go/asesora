<template>
  <div>
    <label>{{ labels.applicantPhonenumber }}:</label>
    <input  id="phonenumber"
            name="phonenumber"
            type="text"
            v-on:focus="onFocus"
            v-on:keydown="keydown"
            v-on:keyup="onKeyup"
            v-model="values.applicantPhonenumber"
            >
  </div>
</template>

<script>
export default {
  name: 'asesora-applicant-phone',

  props: ['labels', 'values'],
  data: { function () {
      commandKey: false
    }
  },

  methods: {

    onKeyup(){
      let valid = this.phoneValidation()

      let signal = new CustomEvent('changed.phone',
                                    {'detail': {"valid":valid},
                                    'bubbles': true})
      this.$el.dispatchEvent(signal)
      this.refreshSuggestion()
    },

    refreshSuggestion() {
      let signal = new CustomEvent('changed.applicant.fields',
                                      {'detail': {},
                                      'bubbles': true})
      this.$el.dispatchEvent(signal)
    },

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


    isArrowKeyCode(keycode){
      let isInitKey = (keycode == 36)
      let isFinKey = (keycode == 35)
      let isSuprKey = (keycode == 46)
      let isLeftArrow = (keycode == 37)
      let isArrowUp = (keycode == 38)
      let isRightArrow = (keycode == 39)
      let isArrowDown = (keycode == 40)

      return isInitKey || isFinKey || isSuprKey
             || isLeftArrow || isRightArrow || isArrowDown || isArrowUp
    },

    isSeparatorKeyCode(keycode){
      let isSpaceBar = (keycode == 32)
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
      let filteredPhoneNumber = this.phoneNumberfilter(field.value)

      field.classList.remove("error")
      if(filteredPhoneNumber == ""){
        return false
      }else if(filteredPhoneNumber.length != 9 ){
        field.classList.add("error")
        return false
      }
      this.values.applicantPhonenumber = filteredPhoneNumber
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
