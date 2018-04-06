import aja from 'aja'

export let APIClient = {

  BASE_URL : 'http://localhost:4567/api/',

  hit: function (endpoint, data, action){
    aja()
    .method('post')
    .body(data)
    .url(this.BASE_URL + endpoint)
    .on('success', action)
    .go();
  }
}
