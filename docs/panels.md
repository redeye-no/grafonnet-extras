---
permalink: /panels/
---

# panels

```jsonnet
local panels = import "github.com/grafana/grafonnet/gen/grafonnet-v11.2.0/panels.libsonnet"
```

Utilities for creating Grafana panels that provide visualisation in dashboards.


## Index

* [`fn new(title='', def={type: 'stat'}, plots, configs, geometry={})`](#fn-new)
* [`fn grid(rows=[], panelWidth=1)`](#fn-grid)
* [`fn row(title='', panels=[], configs, collapses=false)`](#fn-row)

## Fields

### fn new

```ts
new(title='', def={type: 'stat'}, plots, configs, geometry={})
```

Create a new panel that can be displayed in a dashboard.
         Each visualisation is defined by one or more plots.
          A plot defines what data is to be presented/rendered.

### fn grid

```ts
grid(rows=[], panelWidth=1)
```

Create a new grid consisting of the row of panels provided as input.
The panelWidth argument specifies the default size of each panel in the grid (max value is 24).


### fn row

```ts
row(title='', panels=[], configs, collapses=false)
```

Create a new row