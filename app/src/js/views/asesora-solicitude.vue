<template>
  <div>
    <label>{{ labels.applicant }}:</label>
    <input  name="applicant"
            placeholder="*"
            type="text"
            v-bind:class="{error: invalid}"
            v-on:blur="lostFocus"
            v-on:focus="recoverFocus"
            v-model="values.applicant"
            >
    <asesora-date :date='values.date' :labels="labels"></asesora-date>
  </div>
</template>

<script>
import DateView from '../views/asesora-date'
export default {
  name: 'asesora-solicitude',
  props: ['labels', 'invalid', 'values'],
  components: {
    "asesora-date" : DateView
  },
  methods: {
    lostFocus(){
      this.invalid=false
      if (this.values.applicant == "") {
        this.invalid = true
      }
    },
    recoverFocus(){
      this.invalid = true
    }
  }
}
</script>

<style scoped>
  input::placeholder {
    color: red ;
    text-align: right;
    border: red;
  }
  .error {
    border: 1px solid red !important;
  }
</style>
