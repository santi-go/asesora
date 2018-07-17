<template>
  <div>
    <div class="button-inline">
      <a href="#popup" class="popup-link">
        <button type="button">
          {{labels.closeCounseling}}
        </button>
      </a>
    </div>

    <div class="modal-wrapper" id="popup">
       <div class="popup-container">
          <h2>{{labels.closeCounseling}}</h2>
          <asesora-button-close-counseling  :labels="labels"
                                            :values="values">
          </asesora-button-close-counseling>
          <a class="popup-close" href="#">X</a>
       </div>
    </div>
  </div>
</template>

<script>
  import ButtonCloseCounseling from './asesora-button-close-counseling'

  export default {
    name: 'subject-close-modal-open',

    props: ['labels', 'values'],

    components:{
      "asesora-button-close-counseling": ButtonCloseCounseling
    }
  }
</script>

<style scoped>
#popup {
   visibility: hidden;
   opacity: 0;
   margin-top: -300px;
}
#popup:target {
   visibility:visible;
   opacity: 1;
   background-color: rgba(0,0,0,0.8);
   position: fixed;
   top:0;
   left:0;
   right:0;
   bottom:0;
   margin:0;
   z-index: 999;
   transition:all 1s;
}
.popup-container {
   position: relative;
   margin:7% auto;
   padding:30px 50px;
   background-color: #fafafa;
   color:#333;
   border-radius: 3px;
   width:50%;
}
a.popup-close {
   position: absolute;
   top:3px;
   right:3px;
   background-color: #333;
   padding:7px 10px;
   font-size: 20px;
   text-decoration: none;
   line-height: 1;
   color:#fff;
 }
</style>
