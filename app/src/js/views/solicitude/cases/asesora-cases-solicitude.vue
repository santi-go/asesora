<template>
  <div>
    <label>{{ labels.casesData }}</label>
    <textarea id="cases-data"
              v-model="values.casesData"
              disabled
              >
    </textarea>
  </div>
</template>

<script>
export default {
  name: 'asesora-cases-solicitude',

  props: ['labels', 'values'],
  
}
</script>
