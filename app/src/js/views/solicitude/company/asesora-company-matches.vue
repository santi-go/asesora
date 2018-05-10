<template>
  <div>
    <label>{{ labels.suggestions }}</label>
    <table>
      <tbody>
        <tr v-for="item in suggestedcompanies">
          {{item.name }}, {{ item.cif}}, {{item.cnae}}, {{item.employees}}
        </tr>
      </tbody>
    </table>
  </div>
</template>

<script>
  export default {
    name: 'asesora-company-matches',
    props: ['labels', 'suggestedcompanies']
  }
</script>
<style>
  td{
    cursor: pointer;
  }
  label {
    margin-top: 1em;
  }
</style>
