module(..., package.seeall)

_AUTHOR = "Rodrigo Cacilhas <batalema@cacilhas.info>"
_COPYRIGHT = "BSD 2-Clause License 2011 (c) " .. _AUTHOR
_DESCRIPTION = "Socket dispatcher"
_NAME = "Sepia latimanus - log facilities"
_PACKAGE = "sepia.log"


DEBUG = 0
INFO = 1
WARN = 2
WARNING = 2
ERROR = 3
FATAL = 4


local levelname = {
	[0] = "DEBUG",
	[1] = "INFO",
	[2] = "WARNING",
	[3] = "ERROR",
	[4] = "FATAL",
}


local _level = INFO
local _output = io.stdout


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
	log(WARN, fmt, ...)
end


function error(fmt, ...)
	log(ERROR, fmt, ...)
end


function fatal(fmt, ...)
	log(FATAL, fmt, ...)
end
