/*

*/

local grafonnet = import "github.com/grafana/grafonnet/gen/grafonnet-v11.4.0/main.libsonnet";

{
	build(
		type = "",
		def = { type: "" },
		plot = {},
		index = 0
		) :: 
        {
            fieldConfig+: {
                defaults+: {
                    // Absolute thresholds.
                    [if std.objectHas(def, "thresholdAbsolute")
                    && null != def.thresholdAbsolute
                    && std.objectHas(grafonnet.panel[def.type].standardOptions, "threshold") then "thresholds"]+:{
                        mode: "absolute",
                        steps: [   { color: item.color,
                            value: item.value },
                            for item in def.thresholdAbsolute
                        ],
                    },
                    // Percent thresholds.
                    [if std.objectHas(def, "thresholdPercent")
                    && null != def.thresholdPercent
                    && std.objectHas(grafonnet.panel[def.type].standardOptions, "threshold") then "thresholds"]+:{
                        mode: "percentage",
                        steps: [ { color: item.color, value: item.value },
                            for item in def.thresholdPercent
                        ],
                    }
                }
            }
        }
}
/*
        {
            fieldConfig+: {
                defaults+: {
                    thresholds+: {
                        // Absolute thresholds.
                        [if std.objectHas(def, "thresholdAbsolutes")
                        && null != def.thresholdAbsolutes
                        && std.objectHas(grafonnet.panel[def.type].standardOptions, "threshold") then "steps"]:
                        [   { color: item.color,
                            value: item.value },
                            for c in def.thresholdAbsolutes
                        ],
                    }
                }
            }
        }
*/