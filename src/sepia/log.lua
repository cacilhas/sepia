module(..., package.seeall)

_AUTHOR = "Rodrigo Cacilhas <batalema@cacilhas.info>"
_COPYRIGHT = "BSD 2-Clause License 2011 (c) " .. _AUTHOR
_DESCRIPTION = "Socket dispatcher"
_NAME = "Sepia latimanus - log facilities"
_PACKAGE = "sepia.log"


DEBUG = 0
INFO = 1
WARNING = 2
ERROR = 3
FATAL = 4


local levelname = {
	[DEBUG] = "DEBUG",
	[INFO] = "INFO",
	[WARNING] = "WARNING",
	[ERROR] = "ERROR",
	[FATAL] = "FATAL",
}


local _level = INFO
local _output = io.stdout


function config(resource)
	local resource_type = type(resource)

	if resource_type == "table" then
		if resource.level then set_level(resource.level) end
		if resource.output then set_output(resource.output) end

	elseif resource_type == "function" then
		config(resource())

	elseif resource_type == "thread" then
		local status, value = coroutine.resume(resource)
		while status do
			config(value)
			status, value = coroutine.resume(resource)
		end

	else
		error("unsupported type " .. resource_type, 2)
	end
end


function set_level(level)
	if level >= DEBUG and level <= FATAL then
		_level = level
	end
end


function set_output(filename)
	reset()

	if filename == "stdout" then
		_output = io.stdout
		return true

	elseif filename == "stderr" then
		_output = io.stderr
		return true

	else
		local fd, err = io.open(filename, "a")
		if not fd then error(err, 2) end

		_output = fd
		return true
	end
end


function reset()
	if _output ~= io.stdout and _output ~= io.stderr then
		_output:close()
		_output = io.stdout
	end
end


function log(level, fmt, ...)
	if level < _level then return end
	_output:write(os.date "%F %H:%M%S ")
	_output:write("[" .. levelname[level] .. "] ")
	_output:write(fmt:format(...))
	_output:write("\n")
end


function debug(fmt, ...)
	log(DEBUG, fmt, ...)
end


function info(fmt, ...)
	log(INFO, fmt, ...)
end


function warn(fmt, ...)
	log(WARNING, fmt, ...)
end


function error(fmt, ...)
	log(ERROR, fmt, ...)
end


function fatal(fmt, ...)
	log(FATAL, fmt, ...)
end
