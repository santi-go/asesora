 <template>
  <div>
    <label>{{ labels.companyEmployees }}</label>
    <input  id="company-employees"
            name="company-employees"
            type="number"
            min="1"
            v-on:keydown="keydown"
            v-on:keyup="checkNumber"
            :disabled="editCompany"
            v-model="values.companyEmployees"
            >
    </div>
</template>

<script>
export default {
  name: 'asesora-company-employees',

  props: ['labels', 'values', 'editCompany'],

  data: { function () {
      commandKey: false
    }
  },

  methods: {
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
      let isLeftArrow = keycode == 37
      let isArrowUp = keycode == 38
      let isRightArrow = keycode == 39
      let isArrowDown = keycode == 40

      return isLeftArrow || isRightArrow || isArrowDown || isArrowUp
    },

    isValidKeyCode(keycode){
      let isNumber = keycode >= 48 && keycode <= 57
      let isNumericKey = keycode >= 96 && keycode <= 105

      let isBackSpace = keycode == 8
      let isTab = keycode == 9
      let isArrow = this.isArrowKeyCode(keycode)
      let isDelete = keycode == 46

      return isNumber || isNumericKey || isTab || isBackSpace || isDelete || isArrow
    },

    checkNumber(event){
      this.emitSignal()
      let value = event.target.value
      if(!parseInt(value)){
        event.target.value = ""
      }
    },

    emitSignal(){
      let signal = new CustomEvent('changed.company.employees',
                                      {'detail': {},
                                      'bubbles': true})
      this.$el.dispatchEvent(signal)
    }

  }
}
</script>

<style scoped>
  label {
    margin-top: 1em;
  }
</style>
