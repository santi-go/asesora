<template>
  <div>
    <label>{{ labels.proposals }}</label>
    <textarea id="cases-proposals"
              v-model="values.proposals">
    </textarea>
  </div>
</template>

<script>
export default {
  name: 'asesora-proposals-for-action',

  props: ['labels', 'values']
}
</script>
