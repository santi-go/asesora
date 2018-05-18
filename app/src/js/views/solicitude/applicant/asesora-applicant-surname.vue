 <template>
  <div>
    <label>{{ labels.surname }}</label>
    <input  id="surname"
            name="surname"
            type="text"
            :disabled="editionmode"
            v-model="values.surname"
            >
    </div>
</template>

<script>
export default {
  name: 'asesora-applicant-surname',

  props: ['labels', 'values', 'editionmode'],
}
</script>

<style scoped>
</style>
