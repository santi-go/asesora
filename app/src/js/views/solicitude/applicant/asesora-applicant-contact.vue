 <template>
  <div>
    <asesora-phone :values="values"
                   :labels="labels"
                   :editionmode="editionmode"
                   ></asesora-phone>
    <asesora-email :values="values"
                   :labels="labels"
                   :editionmode="editionmode"
                   ></asesora-email>
    <div  id="contact-info" v-bind:class="{hide: isValidContact}">
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

  props: ['labels', 'values', 'isValidContact', 'editionmode'],

  components: {
    "asesora-email" : EmailView,
    "asesora-phone" : PhoneView
  }
}
</script>

<style scoped>
  .hide {
    display: none;
  }
</style>
