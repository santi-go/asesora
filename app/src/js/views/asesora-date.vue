<template>
    <div>
        <label for="date">{{labels.date}}</label>
        <input  id="date"
                type="date"
                v-model="values.date">
        <div v-bind:class="{hide: values.date}">
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
  props: ['labels', 'values'],
}
</script>
<style scoped>
  input[type="date"] {
    border: 0.1rem solid var(--ligth-grey-color);
    border-radius: .4rem;
    box-shadow: none;
    height: 3.8rem;
    padding: .6rem 1rem;
    background-color: transparent;
    margin-bottom: 1.5rem;
    outline: none;
  }
  input:invalid {
      border: 1px solid var(--error-color);
  }
  input:focus {
      border: 1px solid var(--main-color);
  }
  .hide {
    display: none;
  }
</style>
