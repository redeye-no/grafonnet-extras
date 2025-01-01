/*

*/

local grafonnet = import "github.com/grafana/grafonnet/gen/grafonnet-v11.4.0/main.libsonnet";

{
	build(
		type = "",
		def = { type: "" },
		plot = {},
		configs = null,
		index = 0
		) :: 
		grafonnet.panel[def.type].standardOptions.withOverridesMixin([
			if std.objectHas(plot, "ref") then 
			{
				matcher: {
					id: "byFrameRefID",
					options: plot.ref
				},
				properties: [
					{
						id: "custom.axisPlacement",
						value: plot.yAxisPlacement,
					},
					if null != configs
					&& "stat" != type then
                   			{
                        			id: "color",
                        			value: {
                            				mode: "fixed",
                            				fixedColor: configs.plotColors[index % std.length(configs.plotColors)],
                        			}
                    			} else {}
				]
			} else {}
		])

        + (
            if std.objectHas(def, "decimals")
            && null != def.decimals then (
                grafonnet.panel[def.type].standardOptions.withDecimals(def.decimals)
            ) else {}
        )
}

