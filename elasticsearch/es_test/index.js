const elasticsearch = require('elasticsearch');

const client = new elasticsearch.Client({
  host: 'localhost:9200',
  log: 'trace'
});

client.index({ index: ['twitter', 'facebook'] })
  .then(res => console.log('Create indices: ', res))
  .catch(err => console.log('Error: ', err))

const john = {
  name: 'John',
  age: 32,
  twitter: '@john_twitter'
}

const jane = {
  name: 'Jane',
  age: 28,
  twitter: '@jane'
}

client.create({
  index: 'twitter',
  type: 'doc',
  id: 1,
  body: john
})
  .then(res => console.log('Created john: ', res))
  .catch(err => console.log('Error: ', err))

client.create({
  index: 'twitter',
  type: 'doc',
  id: 2,
  body: jane
})
  .then(res => console.log('Created jane: ', res))
  .catch(err => console.log('Error: ', err))

const james = {
  name: 'James',
  age: 43,
  facebook: '@james'
}

const john2 = {
  name: 'John',
  age: 23,
  twitter: '@john',
  facebook: '@john_facebook'
}

client.create({
  index: 'facebook',
  type: 'doc',
  id: 1,
  body: james
})
  .then(res => console.log('Created james: ', res))
  .catch(err => console.log('Error: ', err))

client.create({
  index: 'facebook',
  type: 'doc',
  id: 2,
  body: john2
})
  .then(res => console.log('Created john2: ', res))
  .catch(err => console.log('Error: ', err))

