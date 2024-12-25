/*

*/

local extras = import "github.com/redeye-no/grafonnet-extras/dist/11.0/main.libsonnet";

################
# Input variables

{
    environments::
        extras.inputs.custom(
            name = "envSelect",
            label = "Env",
            description = "The env",
            options = ["node1", "node2"],
        ),

    serviceNames::
        extras.inputs.custom(
            name = "serviceSelect",
            label = "Service",
            description = "The serv",
            options = ["serv1", "serv2"],
        ),

    applications::
        extras.inputs.custom(
            name = "appSelect",
            label = "App",
            description = "The app",
            options = ["frontend", "app", "db"],
        ),
}

