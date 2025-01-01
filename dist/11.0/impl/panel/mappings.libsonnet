/*

*/

local grafonnet = import "github.com/grafana/grafonnet/gen/grafonnet-v11.4.0/main.libsonnet";

{
	build(
		type = "",
		def = { type: "" },
		plot = {},
		index = 0
		) ::
        {
            fieldConfig+: {
                defaults+: {
                    // Value mappings.
                    [if std.objectHas(def, "mappingValue")
                    && null != def.mappingValue
                    && std.objectHas(grafonnet.panel[def.type].standardOptions, "mapping") then "mappings"]+:[
                        {
                            type: "value",
                            options: { [item.value] : { text: item.text, color: item.color }, }
                        },
                        for item in def.mappingValue
                    ],
                }
            }
        }
        +{
            fieldConfig+: {
                defaults+: {
                    // Range mappings.
                    [if std.objectHas(def, "mappingRange")
                    && null != def.mappingRange
                    && std.objectHas(grafonnet.panel[def.type].standardOptions, "mapping") then "mappings"]+:[
                        {
                            type: "range",
                            options: { from: item.from, to: item.to, result: { text: item.text, color: item.color }, }
                        },
                        for item in def.mappingRange
                    ],
                }
            }
        }
        +{
            fieldConfig+: {
                defaults+: {
                    // Regex mappings.
                    [if std.objectHas(def, "mappingRegex")
                    && null != def.mappingRegex
                    && std.objectHas(grafonnet.panel[def.type].standardOptions, "mapping") then "mappings"]+:[
                        {
                            type: "regex",
                            options: { pattern: item.pattern, result: { text: item.text, color: item.color }, }
                        },
                        for item in def.mappingRegex
                    ],
                }
            }
        }
        +{
            fieldConfig+: {
                defaults+: {
                    // Special mappings.
                    [if std.objectHas(def, "mappingSpecial")
                    && null != def.mappingSpecial
                    && std.objectHas(grafonnet.panel[def.type].standardOptions, "mapping") then "mappings"]+:[
                        {
                            type: "special",
                            options: { match: item.match, result: { text: item.text, color: item.color }, }
                        },
                        for item in def.mappingSpecial
                    ],
                }
            }
        }
}

