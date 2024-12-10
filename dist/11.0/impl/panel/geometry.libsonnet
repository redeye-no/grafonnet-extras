/*

*/

local grafonnet = import "github.com/grafana/grafonnet/gen/grafonnet-v11.1.0/main.libsonnet";

{
	build(
		type = "",
		def = { type: "" },
		geometry = {}
		) :: 
		(
			if std.objectHas(geometry, "w")  then 
				grafonnet.panel[type].gridPos.withW(geometry.w)
			else {}
		)
		+(	
			if std.objectHas(geometry, "h")  then 
				grafonnet.panel[type].gridPos.withH(geometry.h)
			else {}
		)
}
