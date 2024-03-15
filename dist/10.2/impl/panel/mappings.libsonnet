/*

*/

local grafonnet = import "github.com/grafana/grafonnet/gen/grafonnet-v10.2.0/main.libsonnet";

{
	build(
		type = "",
		plot = {},
		configs = null,
		index = 0
		) :: 
		grafonnet.panel[type].standardOptions.withMappingsMixin(
			if null != configs then
				configs.statMappings
			else {}
		)
}

