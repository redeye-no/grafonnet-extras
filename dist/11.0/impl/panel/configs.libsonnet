/*

*/

local grafonnet = import "github.com/grafana/grafonnet/gen/grafonnet-v11.4.0/main.libsonnet";

{
	build(
		type = "",
		def = { type: "" },
		plot = {}
	) :: {
	/*
	    Default field configs
	*/
	    fieldConfig+: {
            defaults+: {

                [if std.objectHas(def, "min")
                && null != def.min then "min"]: def.min,

                [if std.objectHas(def, "max")
                && null != def.max then "max"]: def.max,

                custom+: {
                    [if std.objectHas(def, "axisLabel")
                    && null != def.axisLabel then "axisLabel"]: def.axisLabel,

                    [if std.objectHas(def, "axisPlacement")
                    && null != def.axisPlacement then "axisPlacement"]: def.axisPlacement,

                    [if std.objectHas(def, "barAlignment")
                    && null != def.barAlignment then "barAlignment"]: def.barAlignment,

                    [if std.objectHas(def, "barWidthFactor")
                    && def.barWidthFactor >= 0 then "barWidthFactor"]: def.barWidthFactor,

                    [if std.objectHas(def, "drawStyle")
                    && null != def.drawStyle then "drawStyle"]: def.drawStyle,

                    [if std.objectHas(def, "lineInterpolation")
                    && null != def.lineInterpolation then "lineInterpolation"]: def.lineInterpolation,

                    [if std.objectHas(def, "fillOpacity")
                    && def.fillOpacity >= 0 then "fillOpacity"]: def.fillOpacity,

                    [if std.objectHas(def, "gradientMode")
                    && null != def.gradientMode then "gradientMode"]: def.gradientMode,

                    [if std.objectHas(def, "insertNulls")
                    && null != def.insertNulls then "insertNulls"]: def.insertNulls,

                    [if std.objectHas(def, "lineWidth")
                    && def.lineWidth >= 0 then "lineWidth"]: def.lineWidth,

                    [if std.objectHas(def, "pointSize")
                    && def.pointSize >= 0 then "pointSize"]: def.pointSize,

                    [if std.objectHas(def, "showPoints")
                    && null != def.showPoints then "showPoints"]: def.showPoints,

                    [if std.objectHas(def, "spanNulls")
                    && null != def.spanNulls then "spanNulls"]: def.spanNulls,

                    [if std.objectHas(def, "thresholdStyle")
                    && null != def.thresholdStyle then "thresholdsStyle"]: { mode: def.thresholdStyle },

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


