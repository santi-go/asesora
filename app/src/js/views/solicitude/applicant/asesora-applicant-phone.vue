<template>
  <div>
    <label for="phonenumber">{{ labels.applicantPhonenumber }}:</label>
    <input  id="phonenumber"
            name="phonenumber"
            type="text"
            v-on:focus="onFocus"
            v-on:keydown="keydown"
            v-on:keyup="onKeyup"
            v-on:blur="onKeyup"
            v-model="values.applicantPhonenumber"
            >
    <div id="contact-phone" v-if="!isValidPhone">
      <div class="alert background-danger">
        <em class="fa fa-times-circle"></em>
        {{ labels.errorPhone }}
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'asesora-applicant-phone',

  props: ['labels', 'values', 'isValidPhone'],
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
      let InitKey = 36
      let FinKey = 35
      let SuprKey = 46
      let LeftArrow = 37
      let ArrowUp = 8
      let RightArrow = 39
      let ArrowDown = 40

      return [InitKey, FinKey, SuprKey, LeftArrow,
              RightArrow, ArrowDown, ArrowUp].includes(keycode)
    },

    isSeparatorKeyCode(keycode){
      let SpaceBar = 32
      let Period = 190
      let otherPeriod = 110
      let Hyphen = 189
      let otherHyphen = 109

      return [SpaceBar, Period, Hyphen, otherPeriod, otherHyphen].includes(keycode)
    },

    isValidKeyCode(keycode){
      let isNumber = keycode >= 48 && keycode <= 57
      let isNumericKey = keycode >= 96 && keycode <= 105
      let isBackSpace = keycode == 8
      let isTab = keycode == 9
      let isSeparator = this.isSeparatorKeyCode(keycode)
      let isArrow = this.isArrowKeyCode(keycode)

      return [isNumber, isNumericKey, isSeparator,
              isTab, isBackSpace, isArrow].includes(true)
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
