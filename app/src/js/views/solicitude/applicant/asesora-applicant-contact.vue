 <template>
  <div>
    <label>{{ labels.contact }}</label>
    <label>{{ labels.phonenumber }}</label>
    <input  id="phonenumber"
            name="phonenumber"
            placeholder="*"
            type="text"
            v-on:keyup="onKeyUp"
            v-on:focus="onFocus"
            v-on:keydown="keydown"
            v-model="values.applicant.phonenumber"
            >
    <asesora-email :values="values.applicant.email" :labels="labels"></asesora-email>
    </div>
</template>

<script>
import EmailView from './asesora-email'

export default {
  name: 'asesora-applicant-contact',

  props: ['labels', 'values'],

  components: {
    "asesora-email" : EmailView
  },
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
