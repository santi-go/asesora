<template>
    <div>
        <label for="date">{{label}}</label>
        <input  id="date" 
                type="date" 
                v-model="date">
    </div>
</template>
<script>
export default {
  name: 'asesora-solicitude',
  props: ['label', 'date']
}
</script>
<style>
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
  input:valid {
      border: 1px solid #36cebe;
  }
</style>
