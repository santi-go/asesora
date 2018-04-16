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

    <asesora-date :values="values" :labels="labels"></asesora-date>

  <label>{{ labels.text }}</label>
  <textarea placeholder="*"
            v-bind:class="{error: invalidtext}"
            v-on:blur="lostFocusText"
            v-on:focus="recoverFocusText"
            v-model="values.text">
  </textarea>

    <button type="button"
            name="submit"
            class="submitbutton"
            v-bind:disabled="true"
            v-on:click="submit()">
      {{ labels.submit }}
    </button>
    <div class="message-sent alert background-success">
      <em class="fa fa-thumbs-up"></em>
      Todo Ok! Enviando!
    </div>
  </div>
</template>

<script>
import DateView from '../views/asesora-date'
export default {
  name: 'asesora-solicitude',
  props: ['labels', 'invalidapplicant', 'invalidtext', 'values', 'fullfilled'],
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
      this.invalidapplicant = false
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
      this.invalidtext = false
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
    },
    recoverFocus(){
      this.invalid = false
    },
    animate() {
      this.show()
      this.$parent.$emit('moveCard');
    },
    show() {
      let message = document.querySelector(".message-sent")
      message.style.display = 'block'
    },
    submit(){
      let signal = new CustomEvent('submit.solicitude',
                                  {'detail': {},
                                  'bubbles': true})
      this.$el.dispatchEvent(signal)
      let button = this.$el.querySelector('button')
      button.value = this.labels.submitting
      button.disabled = true
    }
  },
  watch: {
    fullfilled: function(val, oldVal){
      console.log("val ", val);
      if (val == true){
        this.animate()
      }
    }
  }
}
</script>

<style scoped>

  input::placeholder {
    text-align: right;
    font-size: 2em;
    color: var(--error-color);
    line-height: 1.4em;
  }
  input::-webkit-input-placeholder {
    line-height: 1.4em;
    transform: translateY(12px);
  }
  .error {
    border: 1px solid var(--error-color) !important;
  }
  textarea{
    min-height: 200px;
    width: 100%;
  }
  textarea::placeholder {
    text-align: right;
    font-size: 2em;
    color: var(--error-color);
  }
  .message-sent {
    margin-bottom: 0;
    margin-top: 1em;
    display: none;
  }
</style>
