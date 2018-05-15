import aja from 'aja'

export let APIClient = {
  BASE_URL : 'http://' + process.env.API_HOST + ':' + process.env.API_PORT.toString() + '/api/',

  hit: function (endpoint, data, action){
    aja()
    .method('post')
    .body(data)
    .url(this.BASE_URL + endpoint)
    .on('success', action)
    .go();
  }
}
