<template>

<div class="header">
  <div class="navbar-header column column-20 col-site-title">
    <div class="navbar-title ">
      <a href="index.html" class="float-left site-title">
        <img class="float-left asesoraicon" src="favicon.ico" alt="Icono Asesora">
        &nbsp;{{title}}
      </a>
    </div>
  </div>
  <div id="links" class="navbar-links column column-50">
      <div class="link">
        <a href="/">
          {{ labels.createSolicitude }}
        </a>
      </div>
      <div class="link">
        <a href="/solicitudes-list.html">
          {{ labels.solicitudeList }}
        </a>
      </div>
  </div>
  <div class="column column-30">

  </div>

</div>


</template>

<script>
export default {
  name: 'asesora-navbar',
  props: ['title', 'version', 'labels']
}
</script>
<style scoped>

.header {
  display: flex;
  width: 100%;
  height: 3em;
}

.navbar-header {
  flex-direction: column;
}

.navbar .navbar-header .navbar-title > * {
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
