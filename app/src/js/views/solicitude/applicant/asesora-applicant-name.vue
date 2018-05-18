 <template>
  <div>
    <label>{{ labels.name }}</label>
    <input  id="name"
            name="name"
            type="text"
            v-model="values.name"
            >
    </div>
</template>

<script>
export default {
  name: 'asesora-applicant-name',

  props: ['labels', 'values'],
}
</script>

<style scoped>
  label {
    margin-top: 1em;
  }
</style>
