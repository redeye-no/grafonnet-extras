---
permalink: /
---

# grafonnet-extras

```jsonnet
local grafonnet-extras = import "github.com/grafana/grafonnet/gen/grafonnet-v11.4.0/main.libsonnet"
```

OO-friendly templating interface to Grafana dashboards.

This library contains the following packages:

`local extras = import "github.com/redeye-no/grafonnet-extras/dist/11.1/main.libsonnet";`
`extras.dashboard` - create dashboards
`extras.panels` - create and configure panels (plots)
`extras.inputs` - inputs/variables
`extras.sources` - visualisation sources
`extras.configs` - visualisation configs

## Usage
    local extras = import "github.com/redeye-no/grafonnet-extras/dist/11.1/main.libsonnet";
    extras.dashboard.new(
        title = "Extras: Simple Dash",
        uid = "02042265-58c5-478f-980e-420d8519961f",
        panels = panels)


## Index

* [`obj dashboard`](#obj-dashboard)
  * [`fn new(title='Unnamed Extras Dashboard', description='', uid='', editable='false, true', timezone="utc, 'IANA TZDB zone ID', browser", schemaVersion=39, configs='extras.config', grid, panels=[], inputs=[], links=[])`](#fn-dashboardnew)
* [`obj panels`](#obj-panels)
  * [`fn new(title='', settings={type: 'stat'}, plots, configs, geometry={})`](#fn-panelsnew)
  * [`fn grid(rows=[], panelWidth=1)`](#fn-panelsgrid)
  * [`fn row(title='', panels=[], configs, collapses=false)`](#fn-panelsrow)
* [`obj sources`](#obj-sources)
  * [`fn plot(ref=[], legend='', description=[], query=[], unit=[], datasource=[], legendMode='list, table, hidden', legendPlacement='bottom, right', yAxisPlacement='auto, left, right', yAxisLogScale='0, 2, 10')`](#fn-sourcesplot)
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
new(title='', settings={type: 'stat'}, plots, configs, geometry={})
```

Create a new panel that can be displayed in a dashboard.
Each visualisation is defined by one or more plots.
A plot defines the data is to be presented/rendered in a panel.

## Usage
First, create a plot (a query with hints on how to display the results)

    local extras = import "github.com/redeye-no/grafonnet-extras/dist/11.1/main.libsonnet";
    local memoryUsedHeapPlot =
        extras.sources.plot(
            ref = "mem_used",
            legend = "used",
            unit = "decabyte",
            query = "base_memory_usedHeap_bytes",
            datasource = configs.uids.prometheus
        );

Then create panels that will visualise the plots. A panel specifies how plots are rendered (time series, gauge, heatmap, etc.) in a dashboard.
A single panel can harbour multiple plots.

    local panels = [
            extras.panels.new(
                title = "Used Memory",
                settings = { type: "timeSeries" },
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
|`plots` | Array of plots that provide the visualisation data. | See previous example |
|`settings` | Panel settings. | `{ type: "stat" }}` |
|`configs` | Common configuration parameters such as refresh intervals, plot colours. | `{ intervals: { refreshDash: "10s", searchWindow: "6h", searchTime: "now" }}` |
|`geometry` | Panel geometry in Grafana units | `{ x:1, y:1, w: 8, h:8 }` |

## Panel settings
Panel settings are controlled by the `settings` argument object. The general syntax is as follows:

    { type: "panelType" }

The `type` attribute assigns the panel a specific type of visualisation. Each type has a set of options that can be provided.
`type` can be one of: alertlist, annonlist, barchart, candlestick, canvas, dashlist, datagrid, debug, geomap, heatmap, histogram, logs, news, nodeGraph, piechart, row, state-timeline, status-history, table, text, timeseries, trend, xychart.

|Attribute|Description|Value, enum, examples|
|----|----|----|
|`barAlignment` | Bar alignment when drawStyle is set to `bar` | -1, 0, 1 |
|`decimals` | Number of decimals to display for values | - |
|`displayMode` |  | basic, lcd, gradient |
|`*displayMode` |  | 'auto', 'color-text', 'color-background', 'color-background-solid', 'gradient-gauge', 'lcd-gauge', 'json-view', 'basic', 'image', 'gauge', 'sparkline', 'data-links', 'custom'. |
|`*displayMode` |  | 'list', 'table', 'hidden' |
|`drawStyle` |  | line, bar, points |
|`fillOpacity` |  | barchart, gauge, histogram, status-history, state-timeline, table, timeSeries, trend |
|`gradientMode` |  | barchart, gauge, histogram, status-history, state-timeline, table, timeSeries, trend |
|`orientation` |  | auto, vertical, horizontal. |
|`lineInterpolation` |  | linear, smooth, stepBefore, stepAfter |
|`lineWidth` |  | Unique identifier. |
|`mappingValue` | Value mappings | `mappingValue: [ { value: "110", text: "one ten", color: "red" } ]` |
|`mappingRange` | Value mappings by range | `mappingRange: [ { from: 0, to: 10, text: "ones", color:"green" } ]` |
|`mappingRegex` | Value mappings using regex | `mappingRegex: [ { pattern: "[0-9]", text: "reggy", color: "#f0f0f0" } ]` |
|`mappingSpecial` | Special value mappings | `mappingSpecial: [ { match: "nan-null", text: "special", color: "blue" } ]` |
|`min` | Configure min value | `min: 1` |
|`max` | Configure max value | `max: 7` |
|`pointSize` | Configure max value | `max: 7` |
|`thresholdAbsolute` | Absolute threshold values | `thresholdAbsolute: [ { "color": "red", "value": 0 }, { "color": "green", "value": 1 }]` |
|`thresholdPercent` | Percentage threshold values | `thresholdPercent: [ { "color": "red", "value": 0 }, { "color": "yellow", "value": 25 }, { "color": "green", "value": 50 }]` |
|`thresholdStyle` | Percentage threshold values | line+area |



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
plot(ref=[], legend='', description=[], query=[], unit=[], datasource=[], legendMode='list, table, hidden', legendPlacement='bottom, right', yAxisPlacement='auto, left, right', yAxisLogScale='0, 2, 10')
```

A plot is an object that defines a datasource, and provides visualisation constraints/configurations.
The configuration parameters include legends, axis settings, tranformations, alerts, etc.

    local extras = import "github.com/redeye-no/grafonnet-extras/dist/11.1/main.libsonnet";
    local memoryUsedHeapPlot =
        extras.sources.plot(
            ref = "mem_used",
            legend = "used",
            unit = "decabyte",
            query = "base_memory_usedHeap_bytes",
            datasource = configs.uids.prometheus,
            settings = {}
        );

## Plot configuration

|Attribute|Description|Examples|
|----|----|----|
|`ref` | Plot reference/id. | Default "" |
|`legend` | Legend text. | "" |
|`description` | Plot description. |  |
|`query` | Specifies the data to be visualised by this plot Query fetches data from a datasource. | `rate(application_http_request_count_total{job='$job', operation='pass'}[$__rate_interval])` |
|`unit` | Unit of plot data. |  |
|`datasource` | Unique ID of the source of data to be visualised. | Prometheus, Loki, InfluxDB, etc. |
|`settings` | Plot settings. | `{ transformLimit: 187 }}` |
|`legendMode` |  | `list, table, hidden` |
|`legendPlacement` |  | `bottom, right` |
|`yAxisPlacement` |  | `auto, left, right` |
|`yAxisLogScale` |  | 0, 2, 10 |

## Plot settings
Plot settings are controlled by the `settings` argument object. The following example sets a limit to the number of data records in the plot:

        settings = { transformLimit: 100 }

|Attribute|Description|Value, enum, examples|
|----|----|----|
|`transformFilterByValue` | Filter plot results by value | `transformFilterByValue: [ { type: "exclude", match: "any", filters: [ field: "totals", filter: "lower", value: 50 ] } ]` |
|`transformFilterByRefID` | Number of decimals to display for values | `transformFilterByRefID: "plotRef1|plotRef2"` |
|`transformLimit` | Limit the number of data records | `transformLimit: "value"` |
|`transformRenameByRegex` | Rename plot results using a regular expression | `transformRenameByRegex: [ { regex: @'.*action="([^"]+)".*', rename: "$1" } ]` |
|`transformTranspose` | Pivot plot data frame | `transformTranspose: { firstName: "", restName: "" }` |


### fn sources.testing

```ts
testing(format='random_walk', legend='', datasource={type: 'datasource', uid: 'grafana'})
```

A prometheus query definition.
