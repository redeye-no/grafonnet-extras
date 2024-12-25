---
permalink: /
---

# grafonnet-extras

```jsonnet
local grafonnet-extras = import "github.com/grafana/grafonnet/gen/grafonnet-v11.4.0/main.libsonnet"
```

OO-friendly templating interface to Grafana dashboards.

This library contains the following packages:

`local extras = import "github.com/redeye-no/grafonnet-extras/dist/10.2/main.libsonnet";`
`extras.dashboard` - create dashboards
`extras.panels` - create and configure panels (plots)
`extras.inputs` - inputs/variables
`extras.sources` - visualisation sources
`extras.configs` - visualisation configs

## Usage
    local extras = import "github.com/redeye-no/grafonnet-extras/dist/10.2/main.libsonnet";
    extras.dashboard.new(
        title = "Extras: Simple Dash",
        uid = "02042265-58c5-478f-980e-420d8519961f",
        panels = panels)


## Index

* [`obj dashboard`](#obj-dashboard)
  * [`fn new(title='Unnamed Extras Dashboard', description='', uid='', editable='false, true', timezone="utc, 'IANA TZDB zone ID', browser", schemaVersion=39, configs='extras.config', grid, panels=[], inputs=[], links=[])`](#fn-dashboardnew)
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
new(title='Unnamed Extras Dashboard', description='', uid='', editable='false, true', timezone="utc, 'IANA TZDB zone ID', browser", schemaVersion=39, configs='extras.config', grid, panels=[], inputs=[], links=[])
```

Create and configures a new dashboard.

## Usage
The most basic dashboard can be created by providing a title, unique identifier, and a panel.

    local extras = import "github.com/redeye-no/grafonnet-extras/dist/10.2/main.libsonnet";
    extras.dashboard.new(
        title = "Extras: Simple Dash",
        uid = "02042265-58c5-478f-980e-420d8519961f",
        panels = panels)

The panels attribute takes an array of panels that will be laid out in the dashboard.
Dash attributes:

|Attribute|Description|
|----|----|
|`title` | Dashboard title. |
|`uid` | Unique identifier. |
|`editable` | Enable dashboard editting (default = false). |
|`timezone` | Timezone ID (default = utc). |
|`configs` | |
|`panels` | Array of panels. Layout is determined at runtime by Grafana. |
|`grid` | Using `grid` in place of `panels` allows for more control over how panels are sized and laid out. |
|`inputs` | Dashboard variablesavailable to the dashboard. |
|`links` | |


## obj panels



### fn panels.new

```ts
new(title='', def={type: 'stat'}, plots, configs, geometry={})
```

Create a new panel that can be displayed in a dashboard.
Each visualisation is defined by one or more plots.
A plot defines the data is to be presented/rendered in a panel.

## Usage
First, create a plot (a query with hints on how to display the results)

    local extras = import "github.com/redeye-no/grafonnet-extras/dist/10.2/main.libsonnet";
    local memoryUsedHeapPlot =
        extras.sources.plot(
            ref = "mem_used",
            legend = "used",
            unit = "decabyte",
            query = "base_memory_usedHeap_bytes",
            datasource = extras.configs.uids.prometheus
        );

Then create panels that will visualise the plots. A panel specifies how plots are rendered (time series, gauge, heatmap, etc.) in a dashboard.
A single panel can harbour multiple plots.

    local panels = [
            extras.panels.new(
                title = "Used Memory",
                def = { type: "timeSeries" },
                plots = [ memoryUsedHeapPlot, memoryCommittedHeapPlot ]
            )
        ];

All plots added to a panel will be rendered in a similar manner. For example, multiple plots added to a panel of type 'gauge' will
all be drawn as gauges.
Now the panels can be added to the dashboard for display.

    extras.dashboard.new(
        title = "Extras: Simple Dash",
        uid = "02042265-58c5-478f-980e-420d8519961f",
        panels = panels)

## Panel configuration

|Attribute|Description|Examples|
|----|----|----|
|`title` | Panel title. | Default "" |
|`def` | Visual definition. | `{ type: "stat" }}` |
|`plots` | Array of plots that provide the visualisation data. | `[]` |
|`configs` | Common configuration parameters. |  |
|`geometry` | Panel geometry in Grafana units | `{ x:1, y:1, w: 8, h:8 }` |

## Panel definition
Panel definitions are controlled by the `def` argument object. The general syntax is as follows:

    { type: "panelType" }

The `type` attribute assigns the panel a specific type of visualisation. Each type has a set of options that can be provided.
`type` can be one of: alertlist, annonlist, barchart, candlestick, canvas, dashlist, datagrid, debug, geomap, heatmap, histogram, logs, news, nodeGraph, piechart, row, state-timeline, status-history, table, text, timeseries, trend, xychart.

|Attribute|Value, enum, Description|Types|
|----|----|----|
|`decimals` | Number of decimals to display for values |  |
|`displayMode` | One of: basic, lcd, gradient. | bargauge, candlestick |
|`*displayMode` | One of: 'auto', 'color-text', 'color-background', 'color-background-solid', 'gradient-gauge', 'lcd-gauge', 'json-view', 'basic', 'image', 'gauge', 'sparkline', 'data-links', 'custom'. | table |
|`*displayMode` | One of: 'list', 'table', 'hidden'. | state-timeline |
|`fillOpacity` | Unique identifier. | barchart, gauge, histogram, status-history, state-timeline, table, timeSeries, trend |
|`orientation` | auto, vertical, horizontal. | bargauge |
|`lineWidth` | Unique identifier. | barchart, gauge, histogram, status-history, state-timeline, table, timeSeries, trend |



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
