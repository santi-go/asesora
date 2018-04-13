<template>
  <div>
    <label>{{ labels.applicant }}:</label>
    <input  name="applicant"
            placeholder="*"
            type="text"
            v-bind:class="{error: invalidapplicant}"
            v-on:blur="lostFocusApplicant"
            v-on:focus="recoverFocusApplicant"
            v-model="values.applicant"
            >
          </input>

    <asesora-date :values='values' :labels="labels"></asesora-date>

    <label>{{ labels.text }}</label>
    <textarea rows="8"
              cols="8"
              placeholder="*"
              v-bind:class="{errortext: invalidtext}"
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
  props: ['labels', 'invalidapplicant', 'invalidtext', 'values'],
  components: {
    "asesora-date" : DateView
  },
  methods: {
      lostFocusApplicant(){
        this.invalidapplicant=false
        if (this.values.applicant == "") {
          this.invalidapplicant = true
        }
        this.enableButton()
      },
      recoverFocusApplicant(){
        this.invalidapplicant = true
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
        let applicantIsEmpty = this.contentApplicant()
        let textIsEmpty = this.contentText()
        this.activateButton(true)
        if (applicantIsEmpty == true && textIsEmpty == true){
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
      this.invalid = false
    }
  }

</script>

<style scoped>
  input::placeholder {
    color: red ;
    text-align: right;
    border: red;
  }
  .error {
    border: 1px solid red !important;
  }
  textarea::placeholder {
    text-align: right;
    font-size: 2em;
    color: red;
  }
  .errortext {
    border: 1px solid red !important;
  }
</style>
