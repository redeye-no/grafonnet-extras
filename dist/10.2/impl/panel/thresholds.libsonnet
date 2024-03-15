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
		{
		/*
		Maybe someone on GitHub can make this work
		
			if std.objectHas(grafonnet.panel[type], "fieldConfig") 
				&& std.objectHas(grafonnet.panel[type].fieldConfig, "defaults") then {
				grafonnet.panel[type].standardOptions.threshold.step.withColor(c.color)
				+ grafonnet.panel[type].standardOptions.threshold.step.withValue(c.value)}
				for c in configs
		*/
		}
}

		/*
		Maybe someone on GitHub can make this work
		
			if std.objectHas(grafonnet.panel[type], "fieldConfig") 
				&& std.objectHas(grafonnet.panel[type].fieldConfig, "defaults") then {
				grafonnet.panel[type].standardOptions.threshold.step.withColor(c.color)
				+ grafonnet.panel[type].standardOptions.threshold.step.withValue(c.value)}
				for c in configs
		*/
