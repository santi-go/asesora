<template>
    <div class="card large-card">
      <div class="card-title">
        <h2>{{ labels.summary }}</h2>
      </div>
        <asesora-summary-solicitude :labels="labels" :values="values"></asesora-summary-solicitude>
        <template v-if="hasSubjects">
          <asesora-subjects-list :labels="labels" :values="values"></asesora-subjects-list>
        </template>

        <div v-if="buttonsPresent">
          <div class="button-inline">
            <button   id='edit-button'
              type="button"
              name="button"
              v-on:click='solicitudeEdit()'>
              {{ labels.edit }}
            </button>
          </div>
          <asesora-button-add-subject :labels="labels" :values="values"></asesora-button-add-subject>
        </div>
    </div>
</template>
<script>
import SummarySolicitudeView from './subjects/asesora-summary-solicitude'
import ButtonAddSubject from './asesora-button-add-subject'
import SubjectsListView from './subjects/asesora-subjects-list'


export default {

  name: 'asesora-show-solicitude',
  props: ['labels', 'values', 'buttonsPresent', 'hasSubjects'],
  methods: {
    solicitudeEdit(){
      let signal = new CustomEvent('load.solicitude',
                                  {'detail': this.values.id,
                                  'bubbles': true})
      this.$el.dispatchEvent(signal)
    }
  },
  computed: {
    hasSubjects: function(){
      return this.values.subjects !=""
    }
  },
  components: {
    "asesora-summary-solicitude" : SummarySolicitudeView,
    "asesora-button-add-subject" : ButtonAddSubject,
    "asesora-subjects-list" : SubjectsListView
  }

}
</script>
