/*

Default configurations for extras. To implement a custom configuration.
Make your own copy of this file in your projects, and provide that to
functions that expect a configuration, for example, extras.panels.new().

Make sure to keep the following reserved objects:
	intervals,
	plotColors

*/
local d = import 'github.com/jsonnet-libs/docsonnet/doc-util/main.libsonnet';

{
    # Default search and refresh intervals for grafana panels
	intervals: {
		refreshDash: "10s",
		searchWindow: "6h",
		searchTime: "now"
	},
	
	# Panel grid dims	
	grid_3x3: {
		small: 3,
		large: self.small * 2,
		row0: 0,
		col0: 0,	
	},
	
	grid_4x4: {
		small: 4,
		large: self.small * 2,
		row0: 0,
		col0: 0,	
	},
	
	coords_1_3: {
		origin: $["grid_3x3"],
		row1: self.origin.row0 + self.origin.small, // because row 0 only has small panels
		row2: self.row1 + self.origin.large, // after row 1, all panels are large
		row3: self.row2 + self.origin.large,
		row4: self.row3 + self.origin.large,
		row5: self.row4 + self.origin.large,
		row6: self.row5 + self.origin.large,	
		col1small: self.origin.col0 + self.origin.small,
		col1: self.origin.col0 + self.origin.large,
		col2: self.col1 + self.origin.large,
		col3: self.col2 + self.origin.large,
		col4: self.col3 + self.origin.large,
		col5: self.col4 + self.origin.large,
		col6: self.col5 + self.origin.large,	
	},
	
	coords_1_4: {
		origin: $["grid_4x4"],
		row1: self.origin.row0 + self.origin.small, // because row 0 only has small panels
		row2: self.row1 + self.origin.large, // after row 1, all panels are large
		row3: self.row2 + self.origin.large,
		row4: self.row3 + self.origin.large,
		row5: self.row4 + self.origin.large,
		row6: self.row5 + self.origin.large,	
		col1small: self.origin.col0 + self.origin.small,
		col1: self.origin.col0 + self.origin.large,
		col2: self.col1 + self.origin.large,
		col3: self.col2 + self.origin.large,
		col4: self.col3 + self.origin.large,
		col5: self.col4 + self.origin.large,
		col6: self.col5 + self.origin.large,	
	},
	
	dims: {
		# Grid with 1 stat top row and a 3 panel wide grid
		grid_1_3: $["coords_1_3"] ,
		
		# Grid with 1 stat top row and a 4 panel wide grid
		grid_1_4: $["coords_1_4"] ,
	},

/*
Check out: https://www.heavy.ai/blog/12-color-palettes-for-telling-better-stories-with-your-data

roygbv-ai       - "#fd7f6f", "#ffa600", "#ffee65", "#5ad45a", "#7eb0d5", "#bd7ebe", "#fdcce5"
springpastels   - "#fd7f6f", "#7eb0d5", "#b2e061", "#bd7ebe", "#ffb55a", "#ffee65", "#beb9db", "#fdcce5", "#8bd3c7"
*/
    # A colour palette for panels with multiple plots
	plotColors: [
        "#7eb0d5", "#b2e061", "#bd7ebe", "#fd7f6f", "#ffb55a", "#ffee65", "#beb9db", "#8bd3c7", "#fdcce5"
	],

	upDownThresholds : [
      { "color": "red", "value": null },
      { "color": "red", "value": 0 },
      { "color": "green", "value": 1 }
    ],

	statThresholdPercents : [
        { "color": "red",  "value": null },
        { "color": "red", "value": 0 },
        { "color": "yellow", "value": 0 },
        { "color": "green", "value": 0.001 }
    ],
	
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
	
	statMappingsUpDown_________: [
		{
			"type": "value",
			"options": {
				"0": {
					"text": "Down",
					"color": "red",
					"index": 1
				}
			}
		},
		{
			"type": "special",
			"options": {
				"match": "null+nan",
				"result": {
					"text": "Down",
					"index": 0,
					"color": "red"
				}
			}
		},
		{
			"type": "range",
			"options": {
				"from": 0.00001,
				"to": 99999999999,
				"result": {
					"text": "Up",
					"index": 2,
					"color": "green"
				}
			}
		}
	],	
}

