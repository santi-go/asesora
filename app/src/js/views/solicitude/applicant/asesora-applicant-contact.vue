 <template>
  <div>
    <asesora-applicant-phone :values="values"
                   :labels="labels"
                   ></asesora-applicant-phone>
    <asesora-applicant-email :values="values"
                   :labels="labels"
                   ></asesora-applicant-email>
    <div  id="contact-info" v-if="this.showMessage()">
      <div class="alert background-danger">
        <em class="fa fa-times-circle"></em>
         {{ labels.noContact }}
      </div>
    </div>
  </div>
</template>

<script>
import EmailView from './asesora-applicant-email'
import PhoneView from './asesora-applicant-phone'

export default {
  name: 'asesora-applicant-contact',

  props: ['labels', 'values', 'editionmode', 'isValidContact'],

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
