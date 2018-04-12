<template>
  <div>
    <label>{{ labels.applicant }}:</label>
    <input  name="applicant"
            placeholder="*"
            type="text"
            v-bind:class="{error: invalidApplicant}"
            v-on:blur="lostFocus"
            v-on:focus="recoverFocus"
            v-model="values.applicant"
            >
          </input>

    <asesora-date :date='values.date' :label="labels.date"></asesora-date>

    <label>{{ labels.text }}</label>
    <textarea rows="8"
              cols="8"
              placeholder="*"
              v-bind:class="{error: invalidtext}"
              v-on:blur="lostFocusText"
              v-on:focus="recoverFocusText"
              v-model="values.text">
    </textarea>

    <button type="button"
            name="submit"
            class="submitbutton"
            v-bind:disabled="true"
            >XXXXX</button>
  </div>
</template>

<script>
import DateView from '../views/asesora-date'
export default {
  name: 'asesora-solicitude',
  props: ['labels', 'invalidApplicant', 'invalidtext', 'values'],
  components: {
    "asesora-date" : DateView
  },
  methods: {
      lostFocus(){
        this.invalid=false
        this.activateButton(true)
        if (this.values.applicant == "") {
          this.invalid = true
        }
        this.enableButton()
      },
      recoverFocus(){
        this.invalid = true
      },
      lostFocusText(){
        this.invalidtext=false
        this.activateButton(true)
        if (this.values.text == "") {
          this.invalidtext = true
        }
        this.enableButton()
      },
      recoverFocusText(){
        this.invalidtext = true
      },
      enableButton(){
        let applicant = this.contentApplicant()
        let text = this.contentText()
        if (applicant == true && text == true){
          this.activateButton(false)
          }
      },
      contentText(){
        return !(this.values.text == "")
      },
      contentApplicant(){
        return !(this.values.applicant == "")
      },
      activateButton(toggle){
        document.querySelector(".submitbutton").disabled = toggle
      }
    },
    recoverFocus(){
      this.invalid = true
    }
  }

</script>

<style scoped>
  input::placeholder {
    color: red ;
    text-align: right;
    border: red;
  }
  textarea::placeholder {
    text-align: right;
    font-size: 2em;
    color: red;
  }
  .error {
    border: 1px solid red !important;
  }
</style>
