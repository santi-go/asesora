<template>
  <div>
    <label for="solicitude-text">{{ labels.text }}<span>*</span></label>
    <textarea id="solicitude-text"
              v-on:keyup="onKeyup"
              v-on:focus="onFocus"
              v-model="values.text">
    </textarea>
  </div>
</template>

<script>
export default {
  name: 'asesora-text',

  props: ['labels', 'values'],

  methods: {
    onKeyup(event){
      event.target.classList.remove("error")
      if (event.target.value == "") {
        event.target.classList.add("error")
      }

      let signal = new CustomEvent('changed.text',
                                      {'detail': {},
                                      'bubbles': true})
      this.$el.dispatchEvent(signal)
    },

    onFocus(event){
      event.target.classList.remove("error")
    }
  }
}
</script>
