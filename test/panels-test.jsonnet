/*

*/
local test = import "github.com/jsonnet-libs/testonnet/main.libsonnet";
local extras = import "github.com/redeye-no/grafonnet-extras/dist/10.2/main.libsonnet";

local gridDefault = extras.panels.grid();
local rowDefault = extras.panels.row();
local panelDefault = extras.panels.new();

test.new(std.thisFile)

+ test.case.new(
	name='empty grid',
	test=test.expect.eq(
		actual = std.length(gridDefault),
		expected = 0
	)
)

+ test.case.new(
	name='row title',
	test=test.expect.eq(
		actual = rowDefault.title,
		expected = ""
	)
)

+ test.case.new(
	name='row panels type',
	test=test.expect.eq(
		actual = std.type(rowDefault.panels),
		expected = "array"
	)
)

+ test.case.new(
	name='row panels count',
	test=test.expect.eq(
		actual = std.length(rowDefault.panels),
		expected = 0
	)
)

+ test.case.new(
	name='row collapsed',
	test=test.expect.eq(
		actual = rowDefault.collapsed,
		expected = false
	)
)

+ test.case.new(
	name='row panel type',
	test=test.expect.eq(
		actual = rowDefault.type,
		expected = "row"
	)
)

+ test.case.new(
	name='default panel title',
	test=test.expect.eq(
		actual = panelDefault.title,
		expected = ""
	)
)

+ test.case.new(
	name='default panel type',
	test=test.expect.eq(
		actual = panelDefault.type,
		expected = "stat"
	)
)

