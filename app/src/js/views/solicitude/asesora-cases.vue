<template>
    <div class="card large-card">
      <asesora-proposals-for-action :labels="labels" :values="values"></asesora-proposals-for-action>
    </div>
</template>
<script>
import ProposalsView from './cases/asesora-proposals-for-action'

export default {

  name: 'asesora-cases',
  props: ['labels', 'values'],
  components: {
    "asesora-proposals-for-action" : ProposalsView
  }
}
</script>
<style scoped>
</style>
