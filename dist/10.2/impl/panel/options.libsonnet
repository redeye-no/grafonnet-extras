/*

*/

local grafonnet = import "github.com/grafana/grafonnet/gen/grafonnet-v10.2.0/main.libsonnet";

{
	build(
		type = "",
		plot = {},
		configs = null
	) :: 
	grafonnet.panel[type].queryOptions.withInterval(
		if null != configs then
			configs.intervals.refreshDash
		else "10s")
		
	+ (
		if std.objectHas(plot, "unit") 
		&& null != plot.unit then (
			grafonnet.panel[type].standardOptions.withUnit(plot.unit)
		) else {}
	)
	
	/*
	+ (
		if std.objectHas(plot, "legendMode") 
		&& null != plot.legendMode 
		&& std.objectHas(grafonnet.panel[type].options, "legend")
		&& std.objectHas(grafonnet.panel[type].options.legend, "withDisplayMode") then (
			grafonnet.panel[type].options.legend.withDisplayMode(plot.legendMode)
			+ grafonnet.panel[type].options.legend.withCalcs([ 'lastNotNull', 'max', ])
		) else {}
	)
	*/
	
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


