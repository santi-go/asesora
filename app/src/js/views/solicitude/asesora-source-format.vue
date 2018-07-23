<template>
  <div>
    <label for="source">{{labels.source}}
      <label  v-if="!values.source.text"
              class="fa fa-warning"
              :title="labels.required"
              :alt="labels.required">
      </label>
    </label>
    <basic-select id="source"
                  :options="sourceCatalog"
                  :selected-option="values.source"
                  @select="onSelect"
                  v-model="values.source"
                  >
    </basic-select>
  </div>
</template>

<script>
  import { BasicSelect } from 'vue-search-select'

  export default {
    name: 'asesora-source-format',
    props: ['labels', 'values', 'sourceCatalog'],
    methods: {
      onSelect (item) {
        this.values.source = item
        let signal = new CustomEvent('changed.source',
                                        {'detail': "",
                                        'bubbles': true})
        this.$el.dispatchEvent(signal)
      },
      reset () {
        this.item = {}
      },
      selectOption () {
        // select option from parent component
        this.item = this.options[0]
      }
    },
    components: {
      BasicSelect
    }
  }
</script>
<style>
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
