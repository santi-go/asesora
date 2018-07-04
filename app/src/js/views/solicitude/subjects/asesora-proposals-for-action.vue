<template>
  <div>
    <label for="subject-proposals">{{ labels.proposals }}</label>
    <multi-select :options="proposalsCatalog"
                  :selected-options="values.proposals"
                  id="subject-proposals"
                  @select="onSelect"
                  v-on:keyup="changedProposal"
                  v-model="values.proposals">
    </multi-select>
  </div>
</template>

<script>
  import { MultiSelect } from 'vue-search-select'

  export default {
    name: 'asesora-proposals-for-action',
    props: ['labels', 'values', 'proposalsCatalog'],
    methods: {
      onSelect (items, lastSelectItem) {
        this.values.proposals = items
        this.changedProposal()
      },
      changedProposal(event) {
        let signal = new CustomEvent('changed.subject',
                                    {'detail': "",
                                    'bubbles': true})
        this.$el.dispatchEvent(signal)
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
