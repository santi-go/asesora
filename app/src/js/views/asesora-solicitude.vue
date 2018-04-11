<template>
  <div>{{ labels.applicant }}
      <asesora-date :label="labels.date"></asesora-date>
  </div>
</template>
<script>
import DateView from '../views/asesora-date'
export default {
  name: 'asesora-solicitude',
  props: ['labels'],
  components: {
    "asesora-date" : DateView
  }
}
</script>
