/*

*/

local grafonnet = import "github.com/grafana/grafonnet/gen/grafonnet-v11.4.0/main.libsonnet";

{
	build(
		plot = {},
		settings = { type: "" },
		index = 0
		) :: 
        {
            fieldConfig+: {
                defaults+: {
                    // Absolute thresholds.
                    [if std.objectHas(settings, "thresholdAbsolute")
                    && null != settings.thresholdAbsolute
                    && std.objectHas(grafonnet.panel[settings.type].standardOptions, "threshold") then "thresholds"]+:{
                        mode: "absolute",
                        steps: [   { color: item.color,
                            value: item.value },
                            for item in settings.thresholdAbsolute
                        ],
                    },
                    // Percent thresholds.
                    [if std.objectHas(settings, "thresholdPercent")
                    && null != settings.thresholdPercent
                    && std.objectHas(grafonnet.panel[settings.type].standardOptions, "threshold") then "thresholds"]+:{
                        mode: "percentage",
                        steps: [ { color: item.color, value: item.value },
                            for item in settings.thresholdPercent
                        ],
                    }
                }
            }
        }
}
