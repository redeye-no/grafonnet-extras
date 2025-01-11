/*

*/

{
	build(
		plot = {},
		settings = {},
		index = 0
	) ::
    {
        /*
        settings = {
            transformRenameByRegex:
            [
                {
                    regex: @'.*action="([^"]+)".*',
                    rename: "$1"
                }
            ]
        }
        */
        [if std.objectHas(settings, "transformRenameByRegex")
        && null != settings.transformRenameByRegex then "transformations"]+:[
            {
                id: "renameByRegex",
                options: {
                    [if std.objectHas(item, "regex") then "regex"]: item.regex,
                    [if std.objectHas(item, "rename") then "renamePattern"]: item.rename,
                }
            },
            for item in settings.transformRenameByRegex
        ]
    }

    + {
        /*
        settings = {
            transformFilterByRefID: "ref1|ref2|ref3"
        }
        */
        [if std.objectHas(settings, "transformFilterByRefID")
        && null != settings.transformFilterByRefID then "transformations"]+:[
            {
                id: "filterByRefId",
                options: {
                    include: settings.transformFilterByRefID,
                }
            }
        ]
    }

    + {
        /*
        settings = {
            transformLimit: "value"
        }
        */
        [if std.objectHas(settings, "transformLimit")
        && null != settings.transformLimit then "transformations"]+:[
            {
                id: "limit",
                options: {
                    limitField: settings.transformLimit,
                }
            }
        ]
    }

    + {
        /*
        settings = {
            transformTranspose: { firstName: "", restName: "" }
        }
        */
        [if std.objectHas(settings, "transformTranspose")
        && null != settings.transformTranspose then "transformations"]+:[
            {
                id: "transpose",
                options: {
                    [if std.objectHas(settings.transformTranspose, "firstName") then "firstFieldName"]: settings.transformTranspose.firstName,
                    [if std.objectHas(settings.transformTranspose, "restName") then "restFieldsName"]: settings.transformTranspose.restName,
                }
            }
        ]
    }

    + {
        /*
        settings = {
            transformFilterByValue:
            [
                {
                    type: "include|exclude",
                    match: "any|all",
                    filters: [
                        field: "",
                        filter: "lower|greater|isNotNull|isNull",
                        value: number
                    ]
                }
            ]
        }
        */
        [if std.objectHas(settings, "transformFilterByValue")
        && null != settings.transformFilterByValue then "transformations"]+:[
            {
                id: "filterByValue",
                options: {
                    [if std.objectHas(item, "type") then "type"]: item.type,
                    [if std.objectHas(item, "match") then "match"]: item.match,

                    filters: [
                    {
                        fieldName: filter.field,
                        config: {
                            id: filter.filter,
                            [if std.objectHas(filter, "value") then "options"]: {
                                value: filter.value
                            }
                        },
                    },
                    for filter in item.filters
                    ]
                }
            },
            for item in settings.transformFilterByValue
        ],
    }
}

