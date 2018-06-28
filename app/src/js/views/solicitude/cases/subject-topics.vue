<template>
  <div>
    <label for="subjects-topics">{{ labels.topics }}</label>
    <div id="subjects-topics">
      <select v-on:blur="selectedItem"
              v-on:click="enableButton">
        <option id="item"
                v-bind:value="fullTopicName(item)"
                v-for="item in topicsCatalog">
          {{ item.name }}
        </option>
      </select>

      <button type="button" name="button" :disabled="noTopic" v-on:click="addItem">Añadir</button>

      <table>
        <tr v-for="item in values.selectedTopics">
          {{item}}
          <button type="button" name="button" v-on:click="remove(item)">borrar</button>
        </tr>
      </table>
    </div>
  </div>
</template>

<script>
  export default {
    name: 'subject-topics',
    props: ['labels', 'values', 'topicsCatalog'],
    data(){
      return {
        separator: ' - ',
        selected: '',
        noTopic: true
      }
    },

    methods:{
      fullTopicName(item){
        return item.id + this.separator + item.name
      },
      enableButton(){
        this.noTopic = false
      },
      selectedItem(event){
        if (event.target.value != "") {
          this.selected = event.target.value
        }
      },
      addItem(){
        if(!this.values.selectedTopics.includes(this.selected)){
          this.values.selectedTopics.push(this.selected)
          let signal = new CustomEvent('add.topics',
                                        {'detail': [],
                                        'bubbles': true})
          this.$el.dispatchEvent(signal)
        }
      },
      remove(item){
        let index = this.values.selectedTopics.indexOf(item)
        this.values.selectedTopics.splice(index, 1)
        let signal = new CustomEvent('remove.topics',
                                      {'detail': [],
                                      'bubbles': true})
        this.$el.dispatchEvent(signal)
      }
    }
  }
  </script>
