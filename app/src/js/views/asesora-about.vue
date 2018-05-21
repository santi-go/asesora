<template>
  <div class="about-header">
    <div class="about-title">
      <img class="float-left asesoraicon" src="favicon.ico" alt="Icono Asesora">
      <a href="index.html" class="site-title float-left">{{title}}</a>
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
  width: 50%;
  flex-direction: column;
}

.navbar .about-header .about-title > * {
  display: inline-flex;
  line-height: 1em;
  margin-bottom: 0;
  vertical-align: text-bottom;
}

.site-title {
  margin-left: -24px;
}

.about-version {
  font-size: 0.8em;
  color: var(--ligth-grey-color);
}

.about-description  {
  margin-left: 20px;
  font-size: 0.8em;
}

.asesoraicon {
  display: inline-flex;
  margin: -10px 0px 0px 20px;
  width: 32px;
  height: 32px;
}
</style>
