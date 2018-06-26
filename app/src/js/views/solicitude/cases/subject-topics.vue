<template>
  <div>
    <div class="card-title">
      <h3>{{ labels.topics }}</h3>
    </div>
  <select v-on:blur="selectedItem">
    <option id="item"
            v-bind:value="fullTopicName(item)"
            v-for="item in topicsCatalog">
            {{ item.name }}
    </option>
  </select>
  <button type="button" name="button" v-on:click="addItem">Añadir</button>
    <table>
      <tr v-for="item in values.selectedTopics">
        {{item}}
        <button type="button" name="button" v-on:click="remove(item)">borrar</button>
      </tr>
    </table>
  </div>
</template>

<script>
  export default {
    name: 'subject-topics',
    props: ['labels', 'values', 'topicsCatalog'],
    data(){
      return {
        separator: ' - ',
        selected: ''
      }
    },

    methods:{
      fullTopicName(item){
        return item.id + this.separator + item.name
      },
      selectedItem(event){
        if (event.target.value !="") {
          this.selected = event.target.value
        }
      },
      addItem(event){
        this.values.selectedTopics.push(this.selected)
        let signal = new CustomEvent('add.topics',
                                      {'detail': [],
                                      'bubbles': true})
        this.$el.dispatchEvent(signal)
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
