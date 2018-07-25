<template>
  <div>
    <label for="subjects-topics">{{ labels.topics }}
      <label  v-if="!values.selectedTopics.length > 0"
              class="fa fa-warning"
              :title="labels.required"
              :alt="labels.required">
      </label>
    </label>
      <multi-select :options="filteredCatalog"
                    :selected-options="values.selectedTopics"
                    id="subjects-topics"
                    @select="onSelect"
                    v-model="values.selectedTopics">
      </multi-select>
  </div>
</template>

<script>
  import { MultiSelect } from 'vue-search-select'

  export default {
    name: 'subject-topics',
    props: ['labels', 'values', 'topicsCatalog', 'submittable'],

    computed: {
        filteredCatalog(){
          return this.parseCatalog(this.topicsCatalog)
        }
    },

    methods:{
      onSelect (items, lastSelectItem) {
        this.values.selectedTopics = items
        this.emitSignal()
      },

      emitSignal(){
        let signal = new CustomEvent('changed.subject',
                                      {'detail':[],
                                      'bubbles':true})
        this.$el.dispatchEvent(signal)
      },

      parseCatalog(catalog){
        return catalog.map((item) => {
                 return {value: item.id,
                        text: item.name}
              })
      }
    },
    components: {
      MultiSelect
    }
  }
  </script>

  <style>
    i.icon {
      display: inline-block;
      font: normal normal normal 14px/1 FontAwesome;
      font-size: inherit;
      text-rendering: auto;
      -webkit-font-smoothing: antialiased;
      -moz-osx-font-smoothing: grayscale;
    }
    i.icon.delete:before {
      content: "\f00d";
    }
    .ui.selection.dropdown .menu > .item {
      font-size: 1.5rem !important;
      border-color: #eee !important;
    }
    .ui.selection.active.dropdown .menu {
      border-color: #eee !important;
    }
    .ui.selection.active.dropdown:hover {
      border-color: #eee !important;
    }
  </style>
