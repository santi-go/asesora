<template>
  <div>
    <label for="applicant-ccaa">{{labels.ccaa}}
      <label  v-if="!values.applicantCcaa.text"
              class="fa fa-warning"
              :title="labels.required"
              :alt="labels.required">
      </label>
    </label>
    <basic-select id="applicant-ccaa"
                  :options="ccaaCatalog"
                  :selected-option="values.applicantCcaa"
                  @select="onSelect"
                  v-model="values.applicantCcaa"
                  >
    </basic-select>
  </div>
</template>

<script>
  import { BasicSelect } from 'vue-search-select'

  export default {
    name: 'asesora-applicant-ccaa',
    props: ['labels', 'values', 'ccaaCatalog'],
    methods: {
      onSelect (item) {
        this.values.applicantCcaa = item
        let signal = new CustomEvent('changed.ccaa',
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
