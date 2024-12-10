/*

*/

local grafonnet = import "github.com/grafana/grafonnet/gen/grafonnet-v11.1.0/main.libsonnet";

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
					{
						id: "displayName",
						value: plot.legend,
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
}

/*
Can this be replaced by something more grafonnet-like, like this?

grafonnet.panel[def.type].standardOptions.override.byFrameRefID.new(plot.ref)
+ grafonnet.panel[def.type].standardOptions.override.byFrameRefID.withFixedColorProperty(configs.plotColors[i % std.length(configs.plotColors)])

*/
