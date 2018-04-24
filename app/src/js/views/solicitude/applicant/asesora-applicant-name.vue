 <template>
  <div>
    <label>{{ labels.name }}</label>
    <input  id="name"
            name="name"
            placeholder="*"
            type="text"
            v-on:keyup="onKeyUp"
            v-on:focus="onFocus"
            v-on:keydown="keydown"
            v-model="values.applicant.name"
            >
    </div>
</template>

<script>
export default {
  name: 'asesora-applicant-name',

  props: ['labels', 'values'],

  methods: {
    onKeyUp(event){
      event.target.className = ""
      if (event.target.value == "") {
        event.target.className = "error"
      }
      this.$parent.$parent.setButtonStatus()
    },

    onFocus(){
      event.target.className = ""
    },

    keydown(event){
      if (event.keyCode == 13){
        event.preventDefault()
      }
    }
  }
}
</script>

<style scoped>
  label {
    margin-top: 1em;
  }
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
