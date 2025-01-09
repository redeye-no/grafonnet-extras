/*

*/

local grafonnet = import "github.com/grafana/grafonnet/gen/grafonnet-v11.4.0/main.libsonnet";

{
	build(
		plot = {},
		settings = { type: "" },
		configs = null,
		index = 0
		) ::
        (
			if std.objectHas(plot, "ref") then {
                fieldConfig+: {
                    overrides+: [
                        {
                            matcher: {
                                id: "byFrameRefID",
                                options: plot.ref,
                            },
                            properties: [
                                {
                                    id: "custom.axisPlacement",
                                    value: plot.yAxisPlacement,
                                },
                                if null != configs
                                && "stat" != settings.type then
                                {
                                    id: "color",
                                    value: {
                                            mode: "fixed",
                                            fixedColor: configs.plotColors[index % std.length(configs.plotColors)]
                                    }
                                },
                                if std.objectHas(plot, "legend")
                                && null != plot.legend then
                                {
                                    id: "displayName",
                                    value: plot.legend
                                }
                            ]
                        }
                    ]
                }
			}
		)
}

