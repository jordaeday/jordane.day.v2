require "http/server"
require "router"

class WebServer
    include Router

    def draw_routes
        get "/" do |context, params|
            context.response.print File.read("./html/example.html")
            context
        end
        get "/resume" do |context, params|
            context.response.print File.read("./html/resume.html")
            context
        end
        get "/test" do |context, params|
            context.response.print File.read("./html/test.html")
            context
        end
        get "*" do |context, params|
            begin
                context.response.print File.read("./img" + context.request.path)
            rescue
                context.response.print File.read("./pdf" + context.request.path)
            else
                #context.response.content_type = "text/html"
                context.response.print 404
                #context.response.print helper("./html/error.html")
            end
            context
        end
    end

    def run
        server = HTTP::Server.new(route_handler)
        server.bind_tcp "0.0.0.0", 8000
        server.listen
    end
end

web_server = WebServer.new
web_server.draw_routes
puts "log"
web_server.run
