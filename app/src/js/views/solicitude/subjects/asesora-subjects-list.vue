<template>
  <div id='subjects-list'>
    <div class="card-title">
      <h3>{{ labels.subjectsList }}</h3>
    </div>

    <div>
      <table>
        <tr v-for="item in values.subjects"
            v-on:click="onClick(item)"
            >
            <td>
            <div class="row grid-responsive">
              <div class="column column-20">
                <h4>{{labels.subject}} {{values.subjects.indexOf(item) +1 }}:</h4>
              </div>
              <div class="column column-80">
                <template v-if="editionSubject == item.id">
                  <asesora-subjects :labels="labels"
                                    :values="values"
                                    :topics-catalog="topicsCatalog"
                                    :proposals-catalog="proposalsCatalog"
                                    :submittable="submittable"
                                    :edition-subject="editionSubject"
                                    :editionmode="editionmode">
                  </asesora-subjects>
                </template>
                <template v-else>
                  <template v-if=" item.proposal.length > 0 ">
                    <label>{{ labels.proposals }}</label>
                    <ul>
                      <li v-for="proposal in item.proposal">
                        {{ proposal }}
                      </li>
                    </ul>
                  </template>
                  <template v-if=" item.analysis !='' ">
                    <label>{{ labels.analysis }}</label>
                    <p>{{ item.analysis }}</p>
                  </template>

                  <template v-if=" item.topics.length > 0 ">
                    <label>{{ labels.topics }}</label>
                    <ul>
                      <li v-for="topic in item.topics">
                        {{ topic.name }}
                      </li>
                    </ul>
                  </template>
                </template>
              </div>
            </div>
          </td>
        </tr>
      </table>
    </div>
  </div>
</template>

<script>
import SubjectsView from '../asesora-subjects'

  export default {
    name: 'asesora-subjects-list',
    props: ['labels', 'values', 'topicsCatalog', 'proposalsCatalog',
            'editionSubject', 'submittable', 'editionmode'],
    components: {
      "asesora-subjects" : SubjectsView
    },
    methods: {
      onClick(item){
        if (item.id != this.editionSubject){
          let signal = new CustomEvent('clicked.subject.list',
                                    {'detail': item,
                                    'bubbles': true})
          this.$el.dispatchEvent(signal)
        }
      }
    }
  }
  </script>
