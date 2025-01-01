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
		refreshDash: "10s",
		searchWindow: "6h",
		searchTime: "now"
	},
	
	plotColors: [
		"red", "orange", "yellow", "green", "blue", "purple"
	],
	
	statThresholdPercents : {
		"steps": [
			{ "color": "red",  "value": null },
			{ "color": "red", "value": 0 },
			{ "color": "green", "value": 0.001 }
		]
	},
	
	statMappings: [
		{
			"type": "value",
			"options": {
				"0": {
					"text": "Down",
					"color": "red",
					"index": 0
				}
			}
		},
		{
			"type": "value",
			"options": {
				"1": {
					"text": "Up",
					"color": "green",
					"index": 1
				}
			}
		}
	],
}

