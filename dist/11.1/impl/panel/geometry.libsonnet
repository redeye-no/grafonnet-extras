/*

*/

local grafonnet = import "github.com/grafana/grafonnet/gen/grafonnet-v11.4.0/main.libsonnet";

{
	build(
		settings = { type: "" },
		geometry = {}
		) :: 
		(
			if std.objectHas(geometry, "w")  then 
				grafonnet.panel[settings.type].gridPos.withW(geometry.w)
			else {}
		)
		+(	
			if std.objectHas(geometry, "h")  then 
				grafonnet.panel[settings.type].gridPos.withH(geometry.h)
			else {}
		)
}
