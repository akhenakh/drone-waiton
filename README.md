# drone-waiton

A drone plugin to wait on external hosts to be available, useful for CI when waiting on a service.

```yaml
kind: pipeline

steps:
- name: waiton
  image: akhenakh/drone-waiton
  settings:
    globaltimeout: 1m
    urltimeout: 10s 
    urls:
    - http://www.google.com
    - http://httpbin.org/delay/5
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
