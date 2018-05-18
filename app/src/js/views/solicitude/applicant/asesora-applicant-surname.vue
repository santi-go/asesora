 <template>
  <div>
    <label>{{ labels.surname }}</label>
    <input  id="surname"
            name="surname"
            type="text"
            v-model="values.surname"
            >
    </div>
</template>

<script>
export default {
  name: 'asesora-applicant-surname',

  props: ['labels', 'values'],
}
</script>

<style scoped>
</style>
