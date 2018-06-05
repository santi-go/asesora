 <template>
  <div>
    <asesora-applicant-phone :values="values"
                   :labels="labels"
                   ></asesora-applicant-phone>
    <asesora-applicant-email :values="values"
                   :labels="labels"
                   ></asesora-applicant-email>
    <div  id="contact-info" v-if="!isValidContact">
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

  props: ['labels', 'values', 'isValidContact'],

  components: {
    "asesora-applicant-email" : EmailView,
    "asesora-applicant-phone" : PhoneView
  }
}
</script>
