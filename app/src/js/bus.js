import Postal from 'postal'

export let Bus = {
  subscribe(topic, action){
    Postal.subscribe({
        topic: topic,
        callback: action
    })
  },

  publish(topic, message){
    Postal.publish({
        topic: topic,
        data: message
    });
  }
}
