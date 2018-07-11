<template>
  <div>
    <label for="solicitude-proposals-description">{{ labels.description }}</label>
    <textarea id="solicitude-proposals-description"
              :placeholder="labels.placeholderdescription"
              v-model="values.description"
              v-on:keyup="onKeyup">
    </textarea>
  </div>
</template>

<script>
export default {
  name: 'solicitude-proposals-description',

  props: ['labels', 'values'],

  methods: {
    onKeyup(event){
      let signal = new CustomEvent('changed.subject',
                                    {'detail': "",
                                    'bubbles': true})
      this.$el.dispatchEvent(signal)
    }
  }
}
</script>
