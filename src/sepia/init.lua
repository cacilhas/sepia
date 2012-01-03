require "sss"
module(..., package.seeall)

_AUTHOR = "Rodrigo Cacilhas <batalema@cacilhas.info>"
_COPYRIGHT = "BSD 2-Clause License 2011 (c) " .. _AUTHOR
_DESCRIPTION = "Socket dispatcher"
_NAME = "Sepia latimanus"
_PACKAGE = "sepia"


local _application = 0
local _address = 0

system = {}

function register_application(app)
	if type(app) == "function" then
		_application = app
		return true
	else
		error("function required", 2)
	end
end


function bind(address)
	if type(address) == "table" and type(address["host"]) == "string" and type(address["port"]) == "number" then
		_address = address
		return true
	else
		error("table with format { host = host, port = port }", 2)
	end
end


function loop()
	if _application == 0 then
		error("no application registered", 2)
	end

	if _address == 0 then
		error("no address bound", 2)
	end

	require "sepia.log"
	system.print = _G.print
	_G.print = sepia.log.info

	local server, status, error
	server = sss.socket(sss.af.inet, sss.sock.stream)
	server:setopt(sss.so.reuseaddr)
	server:bind(_address)
	server:listen(10)

	local thread = require "thread"

	while true do
		local client, host, port = server:accept()
		local f = function ()
			xpcall(
				function () _application(client, { host = host, port = port }) end,
				sepia.log.fatal
			)
			client:close()
		end
		local thr = thread.create(f)
		thr:resume()
	end
end


-- String utils --------------------------------------------------------

string.capitalize = function (self)
	local aux = self:gsub("(%w)(%w*)", function (g1, g2)
		return g1:upper() ..g2:lower()
	end, 1)
	return aux
end


string.capwords = function (self)
	local aux = self:gsub("(%w)(%w*)", function (g1, g2)
		return g1:upper() ..g2:lower()
	end)
	return aux
end


string.deurlize = function (self)
	local aux = {}
	local resp = {}

	if self:find "&" then
		local s
		for s in self:gmatch "([^&]+)" do
				table.insert(aux, s)
		end
	else
		aux = {self}
	end

	table.foreachi(aux, function (i, e)
		local k, v
		if e:find "=" then
			k, v = e:match("^(.-)=(.+)$")
		else
			k, v = nil, e
		end
		v = v:gsub("+", " "):gsub(
			"%%(%x%x)", function (code)
			return string.char(tonumber("0x" .. code))
		end)
		if k then
			k = k:gsub("%[]$", "")
			if resp[k] then
				if type(resp[k]) == "table" then
					table.insert(resp[k], v)
				else
					resp[k] = { resp[k], v }
				end
			else
				resp[k] = v
			end
		else
			table.insert(resp, v)
		end
	end)

	return resp
end


string.endswith = function (self, s)
	local aux = self:match(s .. "$")
		if aux then
			return true
		else
			return false
		end
end


string.join = function (self, t)
	return table.concat(t, self)
end


string.ltrim = function (self)
	local aux = self:gsub("^%s*(.+)$", "%1")
	return aux
end


string.rtrim = function (self)
	local aux = self:gsub("^(.-)%s*$", "%1")
	return aux
end

string.startswith = function (self, s)
	local aux = self:match("^" .. s)
	if aux then
		return true
	else
		return false
	end
end


string.trim = function (self)
	local aux = self:gsub("^%s*(.-)%s*$", "%1")
	return aux
end


string.urlize = function (self)
	local aux = self:gsub("([^0-9a-zA-Z:%s%-%.])", function (c)
		return ("%%%02X"):format(c:byte())
	end)

	aux = aux:gsub("%s", "+")
	return aux
end
