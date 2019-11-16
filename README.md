# jq

A lightweight and flexible command-line JSON processor. http://stedolan.github.io/jq/

[![](https://images.microbadger.com/badges/version/imega/jq.svg)](https://microbadger.com/images/imega/jq "Get your own version badge on microbadger.com") [![](https://images.microbadger.com/badges/image/imega/jq.svg)](http://microbadger.com/images/imega/jq "Get your own image badge on microbadger.com") [![Build Status](https://travis-ci.org/imega-docker/jq.svg?branch=master)](https://travis-ci.org/imega-docker/jq) ![GitHub stars](https://img.shields.io/github/stars/imega-docker/jq?style=social)

Image size: 1 MB (Very lightweight)

From image: alpine:3.10

## Usage

### Example 1 compact instead of pretty-printed output

https://raw.githubusercontent.com/stedolan/jq/master/tests/modules/data.json

```json
{
    "this": "is a test",
    "that": "is too"
}
```

You typing

```
$ curl -s https://raw.githubusercontent.com/stedolan/jq/master/tests/modules/data.json | docker run --rm -i imega/jq -c .
{"this":"is a test","that":"is too"}
```

### Example 2

```
curl -s json-schema.org/draft-04/schema | docker run --rm -i imega/jq -c .
{"id":"http://json-schema.org/draft-04/schema#","$schema":"http://json-schema.org/draft-04/schema#","descri... bla-bla-bla :)
```

### Example 3

```
$ ls
data.json
$ docker run --rm -v `pwd`:/data imega/jq -c . /data/data.json
{"this":"is a test","that":"is too"}
```

### Example 4

```
$ echo "X-RateLimit-Reset: 1452786798" | docker run --rm -i imega/jq -Rc 'split(":") | {(.[0]) : (.[1]|tonumber)}'
{"X-RateLimit-Reset":1452786798}
```

### Conditionals and Comparisons

```
$ echo '[1, 1.0, "1", "banana"]' | docker run --rm -i imega/jq '.[] == 1'
true
true
false
false
```

### Advanced features

```
$ echo '{"foo":10, "bar":200}' | docker run --rm -i imega/jq '.bar as $x | .foo | . + $x'
210
```

### Assignment

```
$ echo '[true,false,[5,true,[true,[false]],false]]' | docker run --rm -i imega/jq '(..|select(type=="boolean")) |= if . then 1 else 0 end'
[
  1,
  0,
  [
    5,
    1,
    [
      1,
      [
        0
      ]
    ],
    0
  ]
]
```

## The MIT License (MIT)

Copyright © 2020 iMega <info@imega.ru>

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
