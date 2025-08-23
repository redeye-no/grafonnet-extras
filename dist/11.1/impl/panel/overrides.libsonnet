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
    {
        fieldConfig+: {
            [if std.objectHas(plot, "ref") then "overrides"]+: [
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
                        if !std.objectHas(plot, "legendFormat") then
                            if std.objectHas(settings, "palette")
                            && null != settings.palette
                            && std.isArray(settings.palette) then
                            {
                                id: "color",
                                value: {
                                    mode: "fixed",
                                    fixedColor: configs.palette[index % std.length(settings.palette)]
                                }
                            } else
                            if null != configs
                            && std.objectHas(configs, "palette")
                            && std.isArray(configs.palette) then
                            {
                                id: "color",
                                value: {
                                    mode: "fixed",
                                    fixedColor: configs.palette[index % std.length(configs.palette)]
                                }
                            } else {}
                        else {},
                        if std.objectHas(plot, "legend")
                        && null != plot.legend then
                        {
                            id: "displayName",
                            value: plot.legend
                        } else {}
                    ]
                },
                if std.objectHas(plot, "legendFormat") then
                {
                    matcher: {
                        id: "byName",
                        options: plot.legendFormat,
                    },
                    properties: [
                        if std.objectHas(settings, "palette")
                        && null != settings.palette
                        && std.isArray(settings.palette) then
                        {
                            id: "color",
                            value: {
                                mode: "fixed",
                                fixedColor: configs.palette[index % std.length(settings.palette)]
                            }
                        } else
                        if null != configs
                        && std.objectHas(configs, "palette")
                        && std.isArray(configs.palette) then
                        {
                            id: "color",
                            value: {
                                mode: "fixed",
                                fixedColor: configs.palette[index % std.length(configs.palette)]
                            }
                        } else {}
                    ]
                },
            ],
        }
    }
}

