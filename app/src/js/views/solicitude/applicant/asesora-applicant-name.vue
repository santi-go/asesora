 <template>
  <div>
    <label>{{ labels.applicantName }}</label>
    <input  id="name"
            name="name"
            type="text"
            v-on:keyup="refreshSuggestion"
            :editionmode="editionmode"
            :disabled="editionmode"
            v-model="values.applicantName"
            >
    </div>
</template>

<script>
export default {
  name: 'asesora-applicant-name',

  props: ['labels', 'values', 'editionmode'],

  methods: {
    refreshSuggestion() {
      let signal = new CustomEvent('changed.applicant.fields',
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
