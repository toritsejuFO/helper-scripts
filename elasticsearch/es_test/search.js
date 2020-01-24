import { Client } from 'elasticsearch';

const client = new Client({
  host: 'localhost:9200',
  log: 'trace'
});

client.search({
  index: ['twitter', 'facebook'],
  body: {
    query: {
      match: {
        _index: 'twitter'
      }
    }
  }
})
.then(res => console.log('Search result: ', res))
.catch(err => console.log('Error: ', err))