 <template>
  <div>
    <label>{{ labels.companyEmployees }}</label>
    <input  id="company-employees"
            name="company-employees"
            type="number"
            min="1"
            v-on:keydown="keydown"
            v-on:blur="checkNumber"
            v-model="values.companyEmployees"
            >
    </div>
</template>

<script>
export default {
  name: 'asesora-company-employees',

  props: ['labels', 'values'],

  methods: {
    keydown(event){
      if(!event.ctrlKey){
        if (!this.isValidKeyCode(event.keyCode)){
          event.preventDefault()
        }
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
      let value = event.target.value
      if(!parseInt(value)){
        event.target.value = ""
      }
    }
  }
}
</script>

<style scoped>
  label {
    margin-top: 1em;
  }
</style>
