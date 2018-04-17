<template>
  <ul>
    <li><a href="/">{{ labels.createSolicitude }}</a></li>
    <li><a href="/listado-asesoramientos">{{ labels.solicitudeList }}</a></li>
  </ul>
</template>

<script>
  export default {
    name: 'asesora-sidebar',
    props: ['labels']
  }
</script>