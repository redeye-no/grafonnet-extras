/*

Default configurations for extras. To implement a custom configuration.
Make your own copy of this file in your projects, and provide that to
functions that expect a configuration, for example, extras.panels.new().

Make sure to keep the following reserved objects:
	intervals,
	palette

*/

{
	# UID defs
	uids: {
		prometheus: "75ba7051-fcec-488c-8cf3-85590396838a"
	},
	
	intervals: {
		refreshDash: "15s",
		searchWindow: "3h",
		searchTime: "now"
	},
	
    # A colour palette for panels with multiple plots
	paletteDarkMore: [
        "#7eb0d5", "#b2e061", "#bd7ebe", "#fd7f6f", "#ffb55a", "#ffee65", "#beb9db", "#8bd3c7", "#fdcce5"
	],

	paletteLightMode: [
        "#a8d5e7", "#d2f0b3", "#d9a9d3", "#fdb6ad", "#ffd8a5", "#fff3a5", "#e1dff1", "#bfe8dc", "#ffe2f0"
	],

	palette: self.paletteLightMode,

	upDownThresholds : [
			{ "color": "red",  "value": null },
			{ "color": "red", "value": 0 },
			{ "color": "green", "value": 1 }
	],

	memRatioThresholds :  [
			{ "color": "red",  "value": null },
			{ "color": "red", "value": 0 },
			{ "color": "yellow", "value": 30 },
			{ "color": "green", "value": 60 }
	],

	upDownMappings: [
	    { value: null, text: "Down", color: "red" },
	    { value: 0, text: "Down" },
	    { value: 1, text: "Up" }
	],
}

