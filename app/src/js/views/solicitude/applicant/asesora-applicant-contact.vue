 <template>
  <div>
    <asesora-phone :values="values" :labels="labels"></asesora-phone>
    <asesora-email :values="values" :labels="labels"></asesora-email>
    </div>
</template>

<script>
import EmailView from './asesora-email'
import PhoneView from './asesora-phone'

export default {
  name: 'asesora-applicant-contact',

  props: ['labels', 'values'],

  components: {
    "asesora-email" : EmailView,
    "asesora-phone" : PhoneView

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
