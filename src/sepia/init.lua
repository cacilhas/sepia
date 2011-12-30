require "sss"
require "latimani"
module(..., package.seeall)

_AUTHOR = "Rodrigo Cacilhas <batalema@cacilhas.info>"
_COPYRIGHT = "BSD 2-Clause License 2011 (c) " .. _AUTHOR
_DESCRIPTION = "Socket dispatcher"
_NAME = "Sepia latimanus"
_PACKAGE = "sepia"


local _application = 0
local _address = 0


function register_application(app)
	if type(app) == "function" then
		_application = app
		return true
	else
		return nil, "function required"
	end
end


function bind(address)
	if type(address) == "table" and type(address["host"]) == "string" and type(address["port"]) == "number" then
		_address = address
		return true
	else
		return nil, "table with format { host = host, port = port }"
	end
end


function loop()
	if _application == 0 then
		return nil, "no application registered"
	end

	if _address == 0 then
		return nil, "no address bound"
	end

	local server, status, error
	server = sss.socket(sss.af.inet, sss.sock.stream)

	status, error = server:setopt(sss.so.reuseaddr)
	if not status then return status, error end

	status, error = server:bind(_address)
	if not status then return status, error end

	status, error = server:listen(10)
	if not status then return status, error end

	local thread = require "thread"

	while true do
		local client, host, port = server:accept()
		local f = function()
			_application(client, { host = host, port = port })
			client:close()
		end
		local thr = thread.create(f)
		thr:resume()
	end
end
