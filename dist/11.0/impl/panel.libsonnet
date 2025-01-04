/*

*/

local grafonnet = import "github.com/grafana/grafonnet/gen/grafonnet-v11.4.0/main.libsonnet";

{
	new(
		title = "",
		def = { type: "stat" }
	) ::
	grafonnet.panel[def.type].new(title)
	+ grafonnet.panel[def.type].panelOptions.withType()
	,
	
	/** ################################################################
	 * @name Dashboard panel row
	 *
	 * @param title Row title.
	 *
	 */
	build(
		title = "",
		def = { type: "stat" },
		plot = {},
		configs = null,
		geometry = {},
		index = 0
	) :: (
		grafonnet.panel[def.type].queryOptions.withTargetsMixin(plot)
		+ (import "panel/configs.libsonnet").build(def = def, plot = plot)
		+ (import "panel/options.libsonnet").build(def = def, plot = plot, configs = configs)
		+ (import "panel/overrides.libsonnet").build(def = def, plot = plot, configs = configs, index = index)
		+ (import "panel/thresholds.libsonnet").build(def = def, plot = plot, index = index)
		+ (import "panel/mappings.libsonnet").build(def = def, plot = plot, index = index)
		# + (import "panel/alerts.libsonnet").build(def = def, plot = plot, configs = configs, index = index)
		+ (import "panel/geometry.libsonnet").build(def = def, geometry = geometry)
	)
	,	
}
