
<template>
  <p class="credit">
    { version }}
  </p>
</template>

<script>
import Version from '../views/version'

export default {
  name: 'footer-asesora',
  components: {
    'version' : Version
  }

}
</script>

<style>
  p {
    padding: 20px 3.5rem !important;
  }
</style>
