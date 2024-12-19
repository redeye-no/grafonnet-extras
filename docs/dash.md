---
permalink: /dash/
---

# dash

```jsonnet
local dash = import "github.com/grafana/grafonnet/gen/grafonnet-v11.2.0/dash.libsonnet"
```

OO-friendly templating utilities for creating Grafana dashboards with extended features


## Index

* [`fn new(title='Unnamed Extras Dashboard', description, uid, editable='false', timezone='utc', configs='extras.config', grid, panels=[], inputs=[], links=[])`](#fn-new)

## Fields

### fn new

```ts
new(title='Unnamed Extras Dashboard', description, uid, editable='false', timezone='utc', configs='extras.config', grid, panels=[], inputs=[], links=[])
```

Create and configures a new dashboard