require "latimani"

return {
	name = "TestLatimani",

	test_capitalize_lower = function(self)
		local parameter = "sepia latimanus"
		local expected = "Sepia latimanus"
		local response = parameter:capitalize()
		self:assertequal(response, expected, response)
	end,

	test_capitalize_upper = function(self)
		local parameter = "SEPIA LATIMANUS"
		local expected = "Sepia LATIMANUS"
		local response = parameter:capitalize()
		self:assertequal(response, expected, response)
	end,

	test_capwords_lower = function(self)
		local parameter = "sepia latimanus"
		local expected = "Sepia Latimanus"
		local response = parameter:capwords()
		self:assertequal(response, expected, response)
	end,

	test_capwords_upper = function(self)
		local parameter = "SEPIA LATIMANUS"
		local expected = "Sepia Latimanus"
		local response = parameter:capwords()
		self:assertequal(response, expected, response)
	end,

	test_deurlize = function(self)
		local parameter = "radiohead=2+%2B+2+%3D+5&porcupinetree=even+less"
		local expected = {
			radiohead = "2 + 2 = 5",
			porcupinetree = "even less",
		}
		local response = parameter:deurlize()
		self:assertequal(response, expected, response)
	end,

	test_endswith_true = function(self)
		self:asserttrue(("this will destroy you"):endswith("you"))
	end,

	test_endswith_false = function(self)
		self:assertfalse(("this will destroy you"):endswith("tree"))
	end,

	test_join = function(self)
		local expected = "1, 2, 3, 4, 5"
		local response = (", "):join { 1, 2, 3, 4, 5 }
		self:assertequal(response, expected, response)
	end,

	test_ltrim_with_spaces = function(self)
		local parameter = "   trim string  "
		local expected = "trim string  "
		local response = parameter:ltrim()
		self:assertequal(response, expected, response)
	end,

	test_ltrim_without_spaces = function(self)
		local parameter = "trim string"
		local expected = "trim string"
		local response = parameter:ltrim()
		self:assertequal(response, expected, response)
	end,

	test_rtrim_with_spaces = function(self)
		local parameter = "   trim string  "
		local expected = "   trim string"
		local response = parameter:rtrim()
		self:assertequal(response, expected, response)
	end,

	test_rtrim_without_spaces = function(self)
		local parameter = "trim string"
		local expected = "trim string"
		local response = parameter:rtrim()
		self:assertequal(response, expected, response)
	end,

	test_trim_with_spaces = function(self)
		local parameter = "   trim string  "
		local expected = "trim string"
		local response = parameter:trim()
		self:assertequal(response, expected, response)
	end,

	test_trim_without_spaces = function(self)
		local parameter = "trim string"
		local expected = "trim string"
		local response = parameter:trim()
		self:assertequal(response, expected, response)
	end,

	test_startswith_true = function(self)
		self:asserttrue(("this will destroy you"):startswith("this"))
	end,

	test_startswith_false = function(self)
		self:assertfalse(("this will destroy you"):startswith("radio"))
	end,

	test_urlize = function(self)
		local parameter = "2 + 2 = 5"
		local expected = "2+%2B+2+%3D+5"
		local response = parameter:urlize()
		self:assertequal(response, expected, response)
	end,
}
