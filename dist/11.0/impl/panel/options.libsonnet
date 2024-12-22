/*

*/

local grafonnet = import "github.com/grafana/grafonnet/gen/grafonnet-v11.4.0/main.libsonnet";

{
	build(
		type = "",
		def = { type: "" },
		plot = {},
		configs = null
	) :: 
	grafonnet.panel[def.type].queryOptions.withInterval(
		if null != configs then
			configs.intervals.refreshDash
		else "10s")
		
	+ (
		if std.objectHas(plot, "unit") 
		&& null != plot.unit then (
			grafonnet.panel[def.type].standardOptions.withUnit(plot.unit)
		) else {}
	)
	
	/*
	+ (
		if std.objectHas(plot, "legendMode") 
		&& null != plot.legendMode 
		&& std.objectHas(grafonnet.panel[def.type].options, "legend")
		&& std.objectHas(grafonnet.panel[def.type].options.legend, "withDisplayMode") then (
			grafonnet.panel[def.type].options.legend.withDisplayMode(plot.legendMode)
			+ grafonnet.panel[def.type].options.legend.withCalcs([ 'lastNotNull', 'max', ])
		) else {}
	)

	// Legend format, because legend_rightSide = true does not work.
	+ {
		[if std.objectHas(def, "legend") then "targets"]+: {
				legend+: {
					format: def.legend,
				}
		}
	}

	+ (
		if std.objectHas(def, "legend")
		&& null != def.legend
		&& std.objectHas(grafonnet.panel[def.type].options, "withLegend") then (
			grafonnet.panel[def.type].options.withLegend(def.displayMode)
		) else {}
	)
	*/

	+ (
		if std.objectHas(def, "legend")
		&& null != def.legend
		&& std.objectHas(grafonnet.panel[def.type].options, "withLegend") then (
			grafonnet.panel[def.type].options.withLegend(def.legend)
		) else {}
	)

	+ (
		if std.objectHas(def, "displayMode")
		&& null != def.displayMode
		&& std.objectHas(grafonnet.panel[def.type].options, "withDisplayMode") then (
			grafonnet.panel[def.type].options.withDisplayMode(def.displayMode)
		) else {}
	)

	+ (
		if std.objectHas(def, "orientation")
		&& null != def.orientation
		&& std.objectHas(grafonnet.panel[def.type].options, "withOrientation") then (
			grafonnet.panel[def.type].options.withOrientation(def.orientation)
		) else {}
	)
	
	// Y-axis scale.
	+ {
		[if std.objectHas(plot, "yAxisLogScale") 
		&& plot.yAxisLogScale > 1 then "fieldConfig"]+: {
			defaults+: {
				custom+: {
					scaleDistribution: {
						type: "log",
						log: plot.yAxisLogScale,
					}
				}
			}
		}
	}

	// Legend placement, because legend_rightSide = true does not work.
	+ {
		[if std.objectHas(plot, "legendPlacement")
		&& "right" == plot.legendPlacement then "options"]+: {
				legend+: {
					placement: "right",
				}
		}
	}
	
	// Plot line style.
	+ {
		[if std.objectHas(plot, "lineWidth") 
		&& plot.lineWidth > 1 then "fieldConfig"]+: {
			defaults+: {
				custom+: {
					lineWidth: plot.lineWidth
				}
			}
		}
	}
}


