<template>
  <div>
    <label>{{labels.reason}}</label>
    <basic-select id="subject-reason"
                  :options="reasonsCatalog"
                  :selected-option="values.reason"
                  :selectedOption="reasonsCatalog[0]"
                  @select="onSelect"
                  v-model="values.reason"
                  >
    </basic-select>
  </div>
</template>

<script>
  import { BasicSelect } from 'vue-search-select'

  export default {
    name: 'asesora-subject-reason',
    props: ['labels', 'values', 'reasonsCatalog'],
    methods: {
      onSelect (item) {
        this.values.reason = item
        let signal = new CustomEvent('changed.reason',
                                        {'detail': "",
                                        'bubbles': true})
        this.$el.dispatchEvent(signal)
      },
      reset () {
        this.item = {}
      },
      selectOption () {
        // select option from parent component
        this.item = this.options[1]
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
