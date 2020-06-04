# drone-waiton

A drone plugin to wait on external hosts to be available, useful for CI when waiting on a service.

In this example pipeline, we spawn a redis service, ask waiton to test for redis avaibility, and then do our work in a task depending on waiton.

```yaml
kind: pipeline

steps:
- name: waiton
  image: akhenakh/drone-waiton:1.0
  settings:
    globaltimeout: 30s
    urls:
    - tcp://cache:6379

- name: service-ready
  image: busybox
  commands:
  - echo "redis ready"
  depends_on:
  - waiton

services:
- name: cache
  image: redis
  ports:
  - 6379
```

## Settings


### `urls`

_**type**_ `[]string`

_**default**_ `''`

_**description**_ List of URLs to test, supported schema are `http://` and `tcp://`.

_**example**_

```yaml
# .drone.yml

kind: pipeline

steps:
- name: waiton
  image: akhenakh/drone-waiton
  settings:
    urls:
    - http://www.google.com
    - http://httpbin.org/delay/5
```

### `globaltimeout`

_**type**_ `string`

_**default**_ `'1m'`

_**description**_ Duration before a timeout error is returned, if tests are not completed yet. 

_**note**_ Duration can be expressed in minute `m`, seconds `s` ...

_**example**_

```yaml
# .drone.yml
# this pipeline will fail because the url will return in 5s but the globaltimeout is set to 3s

kind: pipeline

steps:
- name: waiton
  image: akhenakh/drone-waiton
  settings:
    globaltimeout: 3s
    urls:
    - http://httpbin.org/delay/5
```

### `urltimeout`

_**type**_ `string`

_**default**_ `'10s'`

_**description**_ Duration before timeouting a single request and retrying. 

_**note**_ Duration can be expressed in minute `m`, seconds `s` ...

_**example**_

```yaml
# .drone.yml

kind: pipeline

steps:
- name: waiton
  image: akhenakh/drone-waiton
  settings:
    urltimeout: 3s
    urls:
    - http://httpbin.org/delay/2
```

## Details

The waiton docker image is 4.4MB compressed, based on a distroless image with a simple [Go program](https://github.com/akhenakh/waiton).

For HTTP, waiton is using go-retryablehttp as an HTTP client, using the retries & backoff strategies.

For TCP, waiton is using a simple 1s sleep between retries.
