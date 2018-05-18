 <template>
  <div>
    <label>{{ labels.name }}</label>
    <input  id="name"
            name="name"
            type="text"
            :disabled="editionmode"
            v-model="values.name"
            >
    </div>
</template>

<script>
export default {
  name: 'asesora-applicant-name',

  props: ['labels', 'values', 'editionmode'],
}
</script>

<style scoped>
  label {
    margin-top: 1em;
  }
</style>
