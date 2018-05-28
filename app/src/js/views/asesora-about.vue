<template>
  <div class="about-header">
    <div class="about-title">
      <a href="index.html" class="float-left site-title">
        <img class="float-left asesoraicon" src="favicon.ico" alt="Icono Asesora">
         &nbsp;{{title}}
      </a>
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
}

.about-version {
  margin-top: -4px;
  font-size: 0.8em;
  color: var(--light-grey-color);
}

.about-description  {
  margin-left: 20px;
  font-size: 0.8em;
}

.asesoraicon {
  display: inline-flex;
  margin: -8px 0px 0px 0px;
  width: 32px;
  height: 32px;
}
</style>
