require "mgunit"

table.foreachi(
	{
		"tests/test_latimani.lua",
		"tests/test_log.lua",
	},
	function (_, file)
		local testcase = assert(loadfile(file))()
		mgunit.TestCase:new(testcase)
	end
)

mgunit.main()
