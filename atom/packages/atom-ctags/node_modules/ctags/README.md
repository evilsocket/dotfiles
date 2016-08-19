# Ctags Node module [![Build Status](https://travis-ci.org/atom/node-ctags.png)](https://travis-ci.org/atom/node-ctags)

Read all about ctags [here](http://ctags.sourceforge.net/).

## Installing

```sh
npm install ctags
```

## Building
  * Clone the repository
  * Run `npm install`
  * Run `grunt` to compile the native and CoffeeScript code
  * Run `grunt test` to run the specs

## Documentation

### findTags(tagsFilePath, tag, [options], callback)

Get all tags matching the tag specified from the tags file at the path.

* `tagsFilePath` - The string path to the tags file.

* `tag` - The string name of the tag to search for.

* `options` - An optional options object containing the following keys:

  * `caseInsensitive` - `true` to include tags that match case insensitively,
    (default: `false`)
  * `partialMatch` - `true` to include tags that partially match the given tag
    (default: `false`)

* `callback` - The function to call when complete with an error as the first
             argument and an array containing objects that have `name` and
             `file` keys and optionally a `pattern` key if the tag file
             specified contains tag patterns.

#### Example

```coffeescript
ctags = require 'ctags'

ctags.findTags('/Users/me/repos/node/tags', 'exists', (error, tags=[]) ->
  for tag in tags
    console.log("#{tag.name} is in #{tag.file}")
```

### createReadStream(tagsFilePath, [options])

Create a read stream to a tags file.

The stream returned will emit `data` events with arrays of tag objects
that have `name` and `file` keys and optionally a `pattern` key if the tag file
specified contains tag patterns.

An `error` event will be emitted if the tag file cannot be read.

An `end` event will be emitted when all the tags have been read.

* `tagsFilePath` - The string path to the tags file.

* `options` - An optional object containing the following keys.

  * `chunkSize` - The number of tags to read at a time (default: `100`).

Returns a stream.
#### Example

```coffeescript
ctags = require 'ctags'

stream = ctags.createReadStream('/Users/me/repos/node/tags')
stream.on 'data', (tags) ->
  for tag in tags
    console.log("#{tag.name} is in #{tag.file} with pattern: #{tag.pattern}")
```
