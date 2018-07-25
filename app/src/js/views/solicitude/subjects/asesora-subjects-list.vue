<template>
  <div id='subjects-list'>
    <div class="card-title">
      <h2>{{ labels.subjectsList }}</h2>
    </div>
    <div>
      <table>
        <tr v-for="item in values.subjects"
            v-on:click="onClick(item)">
            <td>
            <div class="row grid-responsive" v-bind:class="{ closedSubject: isClosed(item) }">
              <div class="column column-20">
                <h4>
                  <template v-if="editionmode">{{labels.modify}}</template>
                  {{labels.subject}} {{values.subjects.indexOf(item) +1 }}:
                </h4>

                <template v-if=" isFilled(item.closed) ">
                  <label>{{ labels.closedSubject }}</label>
                  <p>{{ item.closed }}</p>
                </template>

                <template v-if=" item.reason != null ">
                  <label>{{ labels.reason }}</label>
                  <p>{{ item.reason.text }}</p>
                </template>

                <template v-if=" isFilled(item.comments) ">
                  <label>{{ labels.comments }}</label>
                  <p>{{ item.comments }}</p>
                </template>
                <template>
                  <button-delete-subject  :labels="labels"
                                          :values="values"
                                          :subject-id="item.id">
                  </button-delete-subject>
                </template>

              </div>
              <div class="column column-80">
                <template v-if="editionSubject == item.id" >
                 <asesora-subjects-edition :labels="labels"
                                           :values="values"
                                           :topics-catalog="topicsCatalog"
                                           :proposals-catalog="proposalsCatalog"
                                           :submittable="submittable"
                                           :edition-subject="editionSubject"
                                           :editionmode="editionmode"
                                           :reasons-catalog="reasonsCatalog"
                                           :warning-subject="warningSubject"
                                           >
                 </asesora-subjects-edition>
               </template>
               <template v-else>
                 <template>
                   <label>{{ labels.topics }}
                     <label  v-if="!item.topics.length > 0"
                             class="fa fa-warning"
                             :title="labels.required"
                             :alt="labels.required">
                     </label>
                   </label>
                   <ul>
                     <li v-for="topic in item.topics">
                       {{ topic.name }}
                     </li>
                   </ul>
                 </template>

                 <template v-if=" isFilled(item.analysis) ">
                   <label>{{ labels.analysis }}</label>
                   <p>{{ item.analysis }}</p>
                 </template>

                  <template>
                    <label>{{ labels.proposals }}
                      <label  v-if="!item.proposal.length > 0"
                              class="fa fa-warning"
                              :title="labels.required"
                              :alt="labels.required">
                      </label>
                    </label>
                    <ul>
                      <li v-for="proposal in item.proposal">
                        {{ proposal }}
                      </li>
                    </ul>
                  </template>

                  <template v-if=" isFilled(item.description) ">
                    <label>{{ labels.description }}</label>
                    <p>{{ item.description }}</p>
                  </template>
                </template>
              </div>
            </div>
            <template v-if="modifiedSubjectId == item.id">
              <em>{{labels.subjectModified}}</em>
            </template>
          </td>
        </tr>
      </table>
    </div>
  </div>
</template>

<script>
import SubjectsEditionView from './asesora-subjects-edition'
import ButtonDeleteSubject from './button-delete-subject'

  export default {
    name: 'asesora-subjects-list',
    props: ['labels', 'values', 'topicsCatalog', 'proposalsCatalog',
            'editionSubject', 'modifiedSubjectId', 'submittable',
            'editionmode', 'reasonsCatalog', 'warningSubject'],
    components: {
      "asesora-subjects-edition" : SubjectsEditionView,
      "button-delete-subject": ButtonDeleteSubject
    },
    methods: {
      isFilled(value){
        if (value == null) {return false}
        return (value.length > 0)
      },

      isClosed(item){
        if (item.closed !== null){return true}
        return false
      },

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
