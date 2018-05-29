 <template>
  <div>
    <label>{{ labels.applicantSurname }}</label>
    <input  id="surname"
            name="surname"
            type="text"
            v-on:keyup="refreshSuggestion"
            :disabled="editionmode"
            v-model="values.applicantSurname"
            >
    </div>
</template>

<script>
export default {
  name: 'asesora-applicant-surname',

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
</style>
