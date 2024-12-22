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
		grafonnet.panel[def.type].standardOptions.withMappingsMixin(
			if null != configs then
				configs.statMappings
			else {}
		)
}

