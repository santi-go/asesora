<template>
  <div>
    <label>{{ labels.suggestions }}</label>
    <table>
      <tbody>
        <tr v-on:click="selectCompany(item)"
            v-for="item in suggestedcompanies">
            <td>{{item.name }} ({{ item.cif}}), {{item.employees}}, {{item.cnae}}
            </td>
        </tr>
      </tbody>
    </table>
  </div>
</template>

<script>
  export default {
    name: 'asesora-company-matches',
    props: ['labels', 'suggestedcompanies'],

    methods: {
      selectCompany(item){
        let signal = new CustomEvent('fill.company',
                                    {'detail': item,
                                    'bubbles': true})
        this.$el.dispatchEvent(signal)
      }
    }
  }

</script>
<style>
  td{
    cursor: pointer;
  }
  label{
    margin-top: 1em;
  }
</style>
