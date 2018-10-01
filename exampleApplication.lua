dofile("httpserver-functions.lua")

-- Create server and listen on port 80
server=net.createServer(net.TCP, 80)
server:listen(80, function(conn)
	-- print(conn:getpeer())
	conn:on("receive", requestHandler)
end)


-- Responds is a table of {path: function} pairs. Functions are of type: ( client socket, request data -> (work in progress) ). 
-- Functions are called when a client tries to access it's corresponding path in the responds table 
responds = {}


-- Add root
responds["/"] = function( socket, requestData )
-- Send a index.html file to root request
	respondFileRequest(socket, dirPrefix.."/index.html")
end


-- Response to requests to /test
responds["/test"] = function ( socket, requestData )
	head = {}
	head["Connection"] = "close"
	head["Content-Type"] = "text/html"

	responseMetaData = headers( httpCodes.OK, head  ) 

	-- print(requestData)
	-- print(responseMetaData)
	socket:send(responseMetaData .. "Test", function(sock) sock:close() end)
end