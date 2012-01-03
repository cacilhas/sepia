require "sepia"

return {
	name = "TestTableUtils",

	test_map = function (self)
		local t = { 1, 2, 3, 4 }
		local f = function (n) return (n ^ 2) % 10 end
		local expected = { 1, 4, 9, 6 }
		local response = table.map(t, f)
		self:assertequal(response, expected)
	end,

	test_reduce = function (self)
		local t = { 1, 2, 3, 4 }
		local f = function (a, b) return 2 * a + b end
		local expected = 26
		local response = table.reduce(t, f)
		self:assertequal(response, expected)
	end,

	test_reduce_fail = function (self)
		local t = { 2 }
		local f = function (a, b) return 2 * a + b end
		self:assertraise(table.reduce, t, f)
	end,

	test_map_reduce = function (self)
		local t = { 1, 2, 3, 4 }
		local m = function (n) return (n ^ 2) % 10 end
		local r = function (a, b) return 2 * a + b end
		local expected = 48
		local response = table.map_reduce(t, { map = m, reduce = r })
		self:assertequal(response, expected)
	end,
}
