/*

*/

local grafonnet = import "github.com/grafana/grafonnet/gen/grafonnet-v11.4.0/main.libsonnet";

{
	build(
		plot = {},
		settings = { type: "" },
		index = 0
		) ::
        {
            fieldConfig+: {
                defaults+: {
                    // Value mappings.
                    [if std.objectHas(settings, "mappingValue")
                    && null != settings.mappingValue
                    && std.objectHas(grafonnet.panel[settings.type].standardOptions, "mapping") then "mappings"]+:[
                        {
                            type: "value",
                            options: { [item.value] : {
                                    [if std.objectHas(item, "text") then "text"]: item.text,
                                    [if std.objectHas(item, "color") then "color"]: item.color,
                                },
                            }
                        },
                        for item in settings.mappingValue
                    ],
                }
            }
        }
        +{
            fieldConfig+: {
                defaults+: {
                    // Range mappings.
                    [if std.objectHas(settings, "mappingRange")
                    && null != settings.mappingRange
                    && std.objectHas(grafonnet.panel[settings.type].standardOptions, "mapping") then "mappings"]+:[
                        {
                            type: "range",
                            options: { from: item.from, to: item.to, result: {
                                    [if std.objectHas(item, "text") then "text"]: item.text,
                                    [if std.objectHas(item, "color") then "color"]: item.color,
                                },
                            }
                        },
                        for item in settings.mappingRange
                    ],
                }
            }
        }
        +{
            fieldConfig+: {
                defaults+: {
                    // Regex mappings.
                    [if std.objectHas(settings, "mappingRegex")
                    && null != settings.mappingRegex
                    && std.objectHas(grafonnet.panel[settings.type].standardOptions, "mapping") then "mappings"]+:[
                        {
                            type: "regex",
                            options: { pattern: item.pattern, result: {
                                    [if std.objectHas(item, "text") then "text"]: item.text,
                                    [if std.objectHas(item, "color") then "color"]: item.color,
                                },
                            }
                        },
                        for item in settings.mappingRegex
                    ],
                }
            }
        }
        +{
            fieldConfig+: {
                defaults+: {
                    // Special mappings.
                    [if std.objectHas(settings, "mappingSpecial")
                    && null != settings.mappingSpecial
                    && std.objectHas(grafonnet.panel[settings.type].standardOptions, "mapping") then "mappings"]+:[
                        {
                            type: "special",
                            options: { match: item.match, result: {
                                    [if std.objectHas(item, "text") then "text"]: item.text,
                                    [if std.objectHas(item, "color") then "color"]: item.color,
                                },
                            }
                        },
                        for item in settings.mappingSpecial
                    ],
                }
            }
        }
}

