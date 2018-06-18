<template>
    <div class="card large-card">
      <h3>SHOW SOLICITUDE</h3>

      <button     id='edit-button'
                  type="button"
                  name="button"button border="1"
                  v-on:click='solicitudeEdit()'>
            {{ labels.edit }}
      </button>

    </div>
</template>
<script>
export default {

  name: 'asesora-show-solicitude',
  props: ['labels', 'values'],
  methods: {
    solicitudeEdit(){
      let signal = new CustomEvent('load.solicitude',
                                  {'detail': this.values.id,
                                  'bubbles': true})
      this.$el.dispatchEvent(signal)
    }
  }
}
</script>
<style scoped>
</style>
