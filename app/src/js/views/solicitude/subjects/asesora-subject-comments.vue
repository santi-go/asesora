<template>
  <div>
    <label for="solicitude-subject-comments">{{ labels.comments }}</label>
    <textarea id="solicitude-subject-comments"
              :placeholder="labels.placeholdercomments"
              v-model="values.comments"
              v-on:keyup="onKeyup">
    </textarea>
  </div>
</template>

<script>
export default {
  name: 'solicitude-subject-comments',

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
