 <template>
  <div>
    <asesora-phone :values="values" :labels="labels"></asesora-phone>
    <asesora-email :values="values" :labels="labels"></asesora-email>
    <div  id="contact-info" v-bind:class="{hide: isValid}">
      <div class="alert background-danger">
        <em class="fa fa-times-circle"></em>
         {{ labels.noContact }}
      </div>
    </div>
  </div>
</template>

<script>
import EmailView from './asesora-email'
import PhoneView from './asesora-phone'

export default {
  name: 'asesora-applicant-contact',

  props: ['labels', 'values'],

  data() {
    return {
      validEmail: true,
      validPhoneNumber: true,
      isValid: true
    }
  },

  components: {
    "asesora-email" : EmailView,
    "asesora-phone" : PhoneView
  },

  methods: {
    keyup(event){
      this.$parent.$parent.setButtonStatus()
    },
    keydown(event){
      if (event.keyCode == 13){
        event.preventDefault()
      }
    },
    setValidEmail(status){
      this.validEmail = status
      this.setValidation()
    },
    setValidPhonenumber(status){
      this.validPhonenumber = status
      this.setValidation()
    },
    contactIsValid(){
      return this.validEmail || this.validPhonenumber
    },
    setValidation(){
      this.isValid = this.contactIsValid()
      this.$parent.$parent.setContactStatus(this.isValid)
      console.log(this.isValid)
    }
  }
}
</script>

<style scoped>
  .hide {
    display: none;
  }
</style>
