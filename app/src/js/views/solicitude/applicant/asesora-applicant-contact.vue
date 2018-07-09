 <template>
  <div>
    <asesora-applicant-phone :values="values"
                   :labels="labels" :is-valid-phone="isValidPhone"
                   ></asesora-applicant-phone>
    <asesora-applicant-email :values="values"
                   :labels="labels" :is-valid-email="isValidEmail"
                   ></asesora-applicant-email>
  </div>
</template>

<script>
import EmailView from './asesora-applicant-email'
import PhoneView from './asesora-applicant-phone'

export default {
  name: 'asesora-applicant-contact',

  props: ['labels', 'values', 'editionmode', 'isValidContact', 'isValidPhone', 'isValidEmail'],

  components: {
    "asesora-applicant-email" : EmailView,
    "asesora-applicant-phone" : PhoneView
  },

  methods: {
    showMessage() {
      let emailLength = this.values.applicantEmail.length
      let phoneLength = this.values.applicantPhonenumber.length
      if ( (emailLength == 0) && (phoneLength == 0) ){
        return false
      }
      return !this.isValidContact
    }
  }
}
</script>
