/*

*/

local grafonnet = import "github.com/grafana/grafonnet/gen/grafonnet-v11.4.0/main.libsonnet";

{
	build(
		plot = {},
		settings = { type: "" },
		configs = null
	) :: 
	grafonnet.panel[settings.type].queryOptions.withInterval(
		if null != configs then
			configs.intervals.refreshDash
		else "10s")

	/*
	    Standard options
	*/
	+ (
		if std.objectHas(plot, "unit") 
		&& null != plot.unit then (
			grafonnet.panel[settings.type].standardOptions.withUnit(plot.unit)
		) else {}
	)

    + (
        if std.objectHas(settings, "decimals")
        && null != settings.decimals then (
            grafonnet.panel[settings.type].standardOptions.withDecimals(settings.decimals)
        ) else {}
    )

	/*
	    Panel options
	*/

	+ (
		if std.objectHas(settings, "displayMode")
		&& null != settings.displayMode
		&& std.objectHas(grafonnet.panel[settings.type].options, "withDisplayMode") then (
			grafonnet.panel[settings.type].options.withDisplayMode(settings.displayMode)
		) else {}
	)

	+ (
		if std.objectHas(settings, "orientation")
		&& null != settings.orientation
		&& std.objectHas(grafonnet.panel[settings.type].options, "withOrientation") then (
			grafonnet.panel[settings.type].options.withOrientation(settings.orientation)
		) else {}
	)

	/*
	+ (
		if std.objectHas(plot, "legendMode") 
		&& null != plot.legendMode 
		&& std.objectHas(grafonnet.panel[settings.type].options, "legend")
		&& std.objectHas(grafonnet.panel[settings.type].options.legend, "withDisplayMode") then (
			grafonnet.panel[settings.type].options.legend.withDisplayMode(plot.legendMode)
			+ grafonnet.panel[settings.type].options.legend.withCalcs([ 'lastNotNull', 'max', ])
		) else {}
	)

	// Legend format, because legend_rightSide = true does not work.
	+ {
		[if std.objectHas(settings, "legend") then "targets"]+: {
				legend+: {
					format: settings.legend,
				}
		}
	}

	+ (
		if std.objectHas(settings, "legend")
		&& null != settings.legend
		&& std.objectHas(grafonnet.panel[settings.type].options, "withLegend") then (
			grafonnet.panel[settings.type].options.withLegend(settings.displayMode)
		) else {}
	)
	*/

	+ (
		if std.objectHas(settings, "legend")
		&& null != settings.legend
		&& std.objectHas(grafonnet.panel[settings.type].options, "withLegend") then (
			grafonnet.panel[settings.type].options.withLegend(settings.legend)
		) else {}
	)

	// Legend placement, because legend_rightSide = true does not work.
	+ {
		[if std.objectHas(plot, "legendPlacement")
		&& "right" == plot.legendPlacement then "options"]+: {
				legend+: {
					placement: "right",
				}
		}
	}

	+ (
		if std.objectHas(settings, "showThresholdLabels")
		&& null != settings.showThresholdLabels
		&& std.objectHas(grafonnet.panel[settings.type].options, "withLegend") then (
			grafonnet.panel[settings.type].options.withLegend(settings.showThresholdLabels)
		) else {}
	)

	+ {
     	/*
     	    Default field configs
     	*/
     	    options+: {
                 [if std.objectHas(settings, "showThresholdLabels")
                 && null != settings.showThresholdLabels then "showThresholdLabels"]: settings.showThresholdLabels,

                 [if std.objectHas(settings, "showThresholdMarkers")
                 && null != settings.showThresholdMarkers then "showThresholdMarkers"]: settings.showThresholdMarkers,
             }
     	}

}


