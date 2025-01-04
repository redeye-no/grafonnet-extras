/*

Default configurations for extras. To implement a custom configuration.
Make your own copy of this file in your projects, and provide that to
functions that expect a configuration, for example, extras.panels.new().

Make sure to keep the following reserved objects:
	uids,
	intervals,
	plotColors, 
	statThresholdAbsolutes, 
	statThresholdPercents, 
	statMappings

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
	
	plotColors: [
		"#7eb0d5", "#b2e061", "#bd7ebe", "#fd7f6f", "#ffb55a", "#ffee65", "#beb9db", "#8bd3c7", "#fdcce5"
	],

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

