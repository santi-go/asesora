<template>
  <div>
    <label>{{ labels.applicant }}:</label>
    <input  id="applicant"
            name="applicant"
            placeholder="*"
            type="text"
            v-on:blur="onBlur"
            v-on:focus="onFocus"
            v-model="values.applicant"
            >
    </input>

    <asesora-date :values="values" :labels="labels" :editionmode="editionmode"></asesora-date>

  <label>{{ labels.text }}</label>
  <textarea id="solicitude-text"
            placeholder="*"
            v-on:blur="onBlur"
            v-on:focus="onFocus"
            v-model="values.text">
  </textarea>

    <button  id="submit"
            type="button"
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

  props: ['labels', 'values', 'fullfilled', 'editionmode'],

  components: {
    "asesora-date" : DateView
  },

  watch: {
    fullfilled: function(val, oldVal){
      if (val == true){
        this.animateCard()
      }
    }
  },

  methods: {
    onBlur(event){
      event.target.className = ""
      if (event.target.value == "") {
        event.target.className = "error"
      }
      this.enableButton()
    },

    onFocus(){
      event.target.className = ""
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

    animateCard() {
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
  }
}
</script>

<style scoped>

  input::placeholder {
    text-align: right;
    font-size: 32px;
    color: var(--error-color);
    line-height: 1.4em;
  }
  input::-webkit-input-placeholder {
    position: relative;
    top: 12px;
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
    font-size: 32px;
    color: var(--error-color);
  }
  .message-sent {
    margin-bottom: 0;
    margin-top: 1em;
    display: none;
  }
</style>
