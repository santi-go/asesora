<template>
  <div class="about-header">
    <div class="about-title">
      <a href="#" class="site-title float-left">{{title}}</a>
      <p class="about-version">{{ version }}</p>
    </div>
    <p class="about-description">{{ labels.description }}</p>
  </div>
</template>

<script>
export default {
  name: 'asesora-about',
  props: ['title', 'version', 'labels']
}
</script>
<style scoped>
.about-header {
  display: flex;
  width: 30%;
  flex-direction: column;
}

.navbar .about-header .about-title > * {
  display: inline-flex;
  line-height: 1em;
  margin-bottom: 0;
  vertical-align: text-bottom;
}

.about-version {
  font-size: 0.8em;
  color: var(--ligth-grey-color);
}

.about-description  {
  margin-left: 20px;
  font-size: 0.8em;
}
</style>
