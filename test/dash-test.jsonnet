/*

*/
local test = import "github.com/jsonnet-libs/testonnet/main.libsonnet";
local extras = import "github.com/redeye-no/grafonnet-extras/dist/11.1/main.libsonnet";

local dash = extras.dashboard.new(
	title = "Test Dash",
	uid = "b23f6e03-126d-4eb1-bc00-0d03debf78b8",
	panels = null);
		
test.new(std.thisFile)

+ test.case.new(
	name='dash uid',
	test=test.expect.eq(
		actual = dash.uid,
		expected = "b23f6e03-126d-4eb1-bc00-0d03debf78b8"
	)
)

+ test.case.new(
	name='dash title',
	test=test.expect.eq(
		actual = dash.title,
		expected = "Test Dash"
	)
)

+ test.case.new(
	name='dash refresh',
	test=test.expect.eq(
		actual = dash.refresh,
		expected = extras.configs.intervals.refreshDash
	)
)

