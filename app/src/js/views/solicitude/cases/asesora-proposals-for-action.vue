<template>
  <div>
      <label for="subject-proposals">{{ labels.proposals }}</label>
      <multi-select :options="proposalsCatalog"
                    :selected-options="values.proposals"
                    id="subject-proposals"
                    @select="onSelect"
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
      }
    },
  components: {
      MultiSelect
    }
  }
</script>

<style>
  .item {
    font-size: 1.5rem !important;
    border-color: #eee !important;
  }
  .menu {
    border-color: #eee !important;
  }
  .ui.multiple.search.dropdown:hover {
    border-color: #eee !important;
  }
</style>
