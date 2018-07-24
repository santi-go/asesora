<template>
    <div>
      <div>
        <label for="date">{{labels.date}}
          <label  v-if="!values.date"
                  class="fa fa-warning"
                  :title="labels.required"
                  :alt="labels.required">
          </label>
        </label>
      </div>
        <input  id="date"
                type="date"
                v-model="values.date"
                v-on:keyup="onKeyup"
                v-bind:required="editionmode"
                v-bind:class="{editionmode: editionmode}">
    </div>
</template>
<script>
export default {
  name: 'asesora-date',
  props: ['labels', 'values', 'editionmode'],
  computed: {
    mustBeHidden() {
      return (this.editionmode || this.values.date)
    }
  },
  methods: {
    onKeyup(event){
      let signal = new CustomEvent('changed.date',
                                      {'detail': "",
                                      'bubbles': true})
      this.$el.dispatchEvent(signal)
    },
  }
}
</script>
<style scoped>
  input[type="date"] {
    border: 0.1rem solid var(--light-grey-color);
    border-radius: .4rem;
    box-shadow: none;
    height: 3.8rem;
    padding: .6rem 1rem;
    background-color: transparent;
    margin-bottom: 1.5rem;
    outline: none;
  }
  input:focus {
      border: 1px solid var(--main-color);
  }

</style>
