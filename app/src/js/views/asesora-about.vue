<template>

<div class="header">
  <div class="about-header column column-20 col-site-title">
    <div class="about-title ">
      <a href="index.html" class="float-left site-title">
        <img class="float-left asesoraicon" src="favicon.ico" alt="Icono Asesora">
        &nbsp;{{title}}
      </a>
    </div>
  </div>
  <div id="links" class="about-links column column-50 col-search">
      <div class="link">
        <a href="/">
          <em class="fa fa-pencil-square-o"></em>{{ labels.createSolicitude }}
        </a>
      </div>
      <div class="link">
        <a href="/solicitudes-list.html">
          <em class="fa fa-list"></em>{{ labels.solicitudeList }}
        </a>
      </div>
  </div>
  <div class="column column-30">

  </div>

</div>


</template>

<script>
export default {
  name: 'asesora-about',
  props: ['title', 'version', 'labels']
}
</script>
<style scoped>

.header {
  display: flex;
  width: 100%;
}

.about-header {
  flex-direction: column;
}

.navbar .about-header .about-title > * {
  display: inline-flex;
  margin-bottom: 0;
}

.asesoraicon {
  display: inline-flex;
  width: 1.2em;
  height: 1.2em;
  margin-top: 0.2em;

}
</style>
