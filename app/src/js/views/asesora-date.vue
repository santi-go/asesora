<template>
    <div>
        <label for="date">{{labels.date}}</label>
        <input  id="date"
                type="date"
                v-model="date">
        <div v-bind:class="{hide: date}">
          <div class="alert">
            <em class="fa fa-calendar"></em>
             {{ labels.noDate }}
          </div>
        </div>
    </div>
</template>
<script>
export default {
  name: 'asesora-solicitude',
  props: ['labels', 'date'],
}
</script>
<style scoped>
  input[type="date"] {
    border: 0.1rem solid #eee;
    border-radius: .4rem;
    box-shadow: none;
    height: 3.8rem;
    padding: .6rem 1rem;
    background-color: transparent;
    margin-bottom: 1.5rem;
    outline: none;
  }
  input:invalid {
      border: 1px solid #fc4660;
  }
  input:focus {
      border: 1px solid #36cebe;
  }
  .hide {
    display: none;
  }
</style>
