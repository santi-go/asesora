<template>
  <ul>
    <li><a href="/">{{ labels.createSolicitude }}</a></li>
    <li><a href="/solicitudes-list.html">{{ labels.solicitudeList }}</a></li>
  </ul>
</template>

<script>
  export default {
    name: 'asesora-sidebar',
    props: ['labels']
  }
</script>