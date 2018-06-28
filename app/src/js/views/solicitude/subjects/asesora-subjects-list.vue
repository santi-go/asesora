<template>
  <div id='subjects-list'>
    <div class="card-title">
      <h3>{{ labels.subjectsList }}</h3>
    </div>

    <div>
      <table>
        <tr v-for="item in values.subjects">
          <td>
            <div class="row grid-responsive">
              <div class="column column-20">
                <h4>Caso {{values.subjects.indexOf(item) +1 }}:</h4>
              </div>
              <div class="column column-80">
                <label>{{ labels.proposals }}</label>
                <template v-if=" item.proposal =='' "><p>{{ labels.notApply }}</p></template>
                <template v-else><p>{{ item.proposal }}</p></template>

                <label>{{ labels.analysis }}</label>
                <template v-if=" item.analysis =='' "><p>{{ labels.notApply }}</p></template>
                <template v-else><p>{{ item.analysis }}</p></template>

                <label>{{ labels.topics }}</label>
                <template v-if=" item.topics.length == 0 "><p>{{ labels.notApply }}</p></template>
                <template v-else>
                  <tr v-for="topic in item.topics">
                    <td>
                      {{ topic }}
                    </td>
                  </tr>
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
  export default {
    name: 'asesora-subjects-list',
    props: ['labels', 'values']
  }
  </script>
