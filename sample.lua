require "sepia"


local app = function(skt, addr)
	print("Connection from " .. addr.host .. ":" .. addr.port)
	skt:send "> "
	print("Received: " .. skt:receive())
	skt:send "Ok\n"
end

assert(sepia.register_application(app))
assert(sepia.bind { host = "*", port = 65000 })
assert(sepia.loop())
