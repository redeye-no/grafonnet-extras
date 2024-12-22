/*

*/

local extras = import "github.com/redeye-no/grafonnet-extras/dist/11.0/main.libsonnet";
local configs = import "configs.libsonnet";

################
# Create data plots

{
    upDownPlot:
        extras.sources.plot(
            ref = "up_down",
            legend = "state",
            query = "up",
            datasource = configs.uids.prometheus
        ),

    usedMemoryPlot:
        extras.sources.plot(
            ref = "mem_used",
            legend = "used",
            query = "base_memory_usedHeap_bytes",
            datasource = configs.uids.prometheus
        ),

    committedMemoryPlot:
        extras.sources.plot(
            ref = "mem_committed",
            legend = "committed",
            query = "base_memory_committedHeap_bytes",
            datasource = configs.uids.prometheus
        ),
}


