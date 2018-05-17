import aja from 'aja'

export let APIClient = {
  HOST : process.env.API_HOST,
  PORT : process.env.API_PORT,

  hit: function (endpoint, data, action){
    let base_url = `http://${this.HOST}:${this.PORT}/api/`
    aja()
    .method('post')
    .body(data)
    .url(base_url + endpoint)
    .on('success', action)
    .go();
  }
}
