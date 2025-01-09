/*

*/

local grafonnet = import "github.com/grafana/grafonnet/gen/grafonnet-v11.4.0/main.libsonnet";

{
	build(
		type = "",
		settings = { type: "" },
		plot = {}
	) :: {
	/*
	    Default field configs
	*/
	    fieldConfig+: {
            defaults+: {

                [if std.objectHas(settings, "min")
                && null != settings.min then "min"]: settings.min,

                [if std.objectHas(settings, "max")
                && null != settings.max then "max"]: settings.max,

                custom+: {
                    [if std.objectHas(settings, "axisLabel")
                    && null != settings.axisLabel then "axisLabel"]: settings.axisLabel,

                    [if std.objectHas(settings, "axisPlacement")
                    && null != settings.axisPlacement then "axisPlacement"]: settings.axisPlacement,

                    [if std.objectHas(settings, "barAlignment")
                    && null != settings.barAlignment then "barAlignment"]: settings.barAlignment,

                    [if std.objectHas(settings, "barWidthFactor")
                    && settings.barWidthFactor >= 0 then "barWidthFactor"]: settings.barWidthFactor,

                    [if std.objectHas(settings, "drawStyle")
                    && null != settings.drawStyle then "drawStyle"]: settings.drawStyle,

                    [if std.objectHas(settings, "lineInterpolation")
                    && null != settings.lineInterpolation then "lineInterpolation"]: settings.lineInterpolation,

                    [if std.objectHas(settings, "fillOpacity")
                    && settings.fillOpacity >= 0 then "fillOpacity"]: settings.fillOpacity,

                    [if std.objectHas(settings, "gradientMode")
                    && null != settings.gradientMode then "gradientMode"]: settings.gradientMode,

                    [if std.objectHas(settings, "insertNulls")
                    && null != settings.insertNulls then "insertNulls"]: settings.insertNulls,

                    [if std.objectHas(settings, "lineWidth")
                    && settings.lineWidth >= 0 then "lineWidth"]: settings.lineWidth,

                    [if std.objectHas(settings, "pointSize")
                    && settings.pointSize >= 0 then "pointSize"]: settings.pointSize,

                    [if std.objectHas(settings, "showPoints")
                    && null != settings.showPoints then "showPoints"]: settings.showPoints,

                    [if std.objectHas(settings, "spanNulls")
                    && null != settings.spanNulls then "spanNulls"]: settings.spanNulls,

                    [if std.objectHas(settings, "thresholdStyle")
                    && null != settings.thresholdStyle then "thresholdsStyle"]: { mode: settings.thresholdStyle },

                    // Y-axis scale.
                    [if std.objectHas(plot, "yAxisLogScale")
                    && plot.yAxisLogScale > 1 then "scaleDistribution"]: {
                        type: "log",
                        log: plot.yAxisLogScale,
                    }
                }
            }
        }
	}
}


