/*

*/
local test = import "github.com/jsonnet-libs/testonnet/main.libsonnet";
local extras = import "github.com/redeye-no/grafonnet-extras/dist/11.1/main.libsonnet";
local config = import "./common-configs.libsonnet";

local gridDefault = extras.panels.grid();
local rowDefault = extras.panels.row();
local panelDefault = extras.panels.new();

local plot =extras.sources.plot(
                        ref = "mem_used",
                        legend = "used",
                        query = "base_memory_usedHeap_bytes",
                        datasource = configs.uids.prometheus,
                        settings = {
                                transformRenameByRegex: [{ regex: @'.*action="([^"]+)".*', rename: "$1"}],
                                transformFilterByValue: [
                                        {
                                                type: "include",
                                                match: "any",
                                                filters: [{ field: "any", filter: "lower", value: 0.123 }]
                                        }
                                ],
                                transformFilterByRefID: "up_down|mem_used|mem_committed",
                                transformLimit: 187,
                                transformTranspose: { firstName: "name0", restName: "name1" }
                        }
                    );

test.new(std.thisFile)

+ test.case.new(
    name = 'all nangas have a base child',
    test = test.expect.all(
        array = dash.two.nanga,
        predicate = function(item)
          std.objectHas(item, "base")
    )
)

+ test.case.new(
    name = 'one base level',
    test = test.expect.eq(
        actual = dash.one.base.level,
        expected = 2
    )
)

+ test.case.new(
    name = 'two nanga first level',
    test = test.expect.eq(
        actual = dash.two.nanga[0].base.level,
        expected = 20
    )
)

+ test.case.new(
    name = 'two nanga second level',
    test = test.expect.eq(
        actual = dash.two.nanga[1].base.level,
        expected = 21
    )
)