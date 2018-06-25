<template>
  <div>
    <label for="subject-proposals">{{ labels.proposals }}</label>
    <textarea id="subject-proposals"
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
