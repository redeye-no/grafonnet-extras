---
permalink: /
---

# grafonnet-extras

```jsonnet
local grafonnet-extras = import "github.com/grafana/grafonnet/gen/grafonnet-v11.2.0/main.libsonnet"
```

OO-friendly templating interface to Grafana dashboards.

This library contains the following packages:

`local extras = import "github.com/redeye-no/grafonnet-extras/dist/10.2/main.libsonnet";`
`extras.dashboard` - create dashboards
`extras.panels` - create and configure panels (plots)
`extras.inputs` - inputs/variables
`extras.sources` - visualisation sources
`extras.configs` - visualisation configs


## Index

* [`obj dashboard`](#obj-dashboard)
  * [`fn new(title='Unnamed Extras Dashboard', description, uid, editable='false, true', timezone="utc, 'IANA TZDB zone ID', browser", schemaVersion=39, configs='extras.config', grid, panels=[], inputs=[], links=[])`](#fn-dashboardnew)
* [`obj panels`](#obj-panels)
  * [`fn new(title='', def={type: 'stat'}, plots, configs, geometry={})`](#fn-panelsnew)
  * [`fn grid(rows=[], panelWidth=1)`](#fn-panelsgrid)
  * [`fn row(title='', panels=[], configs, collapses=false)`](#fn-panelsrow)
* [`obj sources`](#obj-sources)
  * [`fn plot(ref=[], legend=[], description=[], query=[], unit=[], datasource=[], legendMode='list, table, hidden', legendPlacement='bottom, right', yAxisPlacement='auto, left, right', yAxisLogScale='0, 2, 10')`](#fn-sourcesplot)
  * [`fn prometheus(query, uid='extras.configs.uids.prometheus', format='time_series, table, heatmap', legend='')`](#fn-sourcesprometheus)
  * [`fn testing(format='random_walk', legend='', datasource={type: 'datasource', uid: 'grafana'})`](#fn-sourcestesting)

## Fields

## obj dashboard



### fn dashboard.new

```ts
new(title='Unnamed Extras Dashboard', description, uid, editable='false, true', timezone="utc, 'IANA TZDB zone ID', browser", schemaVersion=39, configs='extras.config', grid, panels=[], inputs=[], links=[])
```

Create and configures a new dashboard


## obj panels



### fn panels.new

```ts
new(title='', def={type: 'stat'}, plots, configs, geometry={})
```

Create a new panel that can be displayed in a dashboard.
Each visualisation is defined by one or more plots.
A plot defines what data is to be presented/rendered.


### fn panels.grid

```ts
grid(rows=[], panelWidth=1)
```

Create a new grid consisting of the row of panels provided as input.
The panelWidth argument specifies the default size of each panel in the grid (max value is 24).


### fn panels.row

```ts
row(title='', panels=[], configs, collapses=false)
```

Create a new row

## obj sources



### fn sources.plot

```ts
plot(ref=[], legend=[], description=[], query=[], unit=[], datasource=[], legendMode='list, table, hidden', legendPlacement='bottom, right', yAxisPlacement='auto, left, right', yAxisLogScale='0, 2, 10')
```

A plot is an object that defines a datasource, and provides visualisation constraints/configurations.
The configuration parameters include legends and axis settings.


### fn sources.prometheus

```ts
prometheus(query, uid='extras.configs.uids.prometheus', format='time_series, table, heatmap', legend='')
```

A prometheus query definition.


### fn sources.testing

```ts
testing(format='random_walk', legend='', datasource={type: 'datasource', uid: 'grafana'})
```

A prometheus query definition.
