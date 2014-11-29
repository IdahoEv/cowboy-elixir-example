defmodule CowboyElixirExample do

  def start(_type, _args) do

    # Compile takes as argument a list of tuples that represent hosts to 
    # match against.So, for example if your DNS routed two different 
    # hostnames to the same server, you could handle requests for those
    # names with different sets of routes. See "Compilation" in:
    #      http://ninenines.eu/docs/en/cowboy/HEAD/guide/routing/
    dispatch = :cowboy_router.compile([

      # :_ causes a match on all hostnames.  So, in this example we are treating
      # all hostnames the same. You'll probably only be accessing this
      # example with localhost:8080.
      { :_, 
        
        # The following list specifies all the routes for hosts matching the
        # previous specification.  The list takes the form of tuples, each one 
        # being { PathMatch, Handler, Options}
        [

          
          # Serve a single static file on the route "/".
          # PathMatch is "/" 
          # Handler is :cowboy_static -- one of cowboy's built-in handlers.  See :
          #   http://ninenines.eu/docs/en/cowboy/HEAD/manual/cowboy_static/
          # Options is a tuple of { type, atom, string }.  In this case:
          #   :priv_file             -- serve a single file
          #   :cowboy_elixir_example -- application name.  This is used to search for
          #                             the path that priv/ exists in.
          #   "index.html            -- filename to serve
          {"/", :cowboy_static, {:priv_file, :cowboy_elixir_example, "index.html"}},


          # Serve all static files in a directory. 
          # PathMatch is "/static/[...]" -- string at [...] will be used to look up the file  
          # Handler is :cowboy_static -- one of cowboy's built-in handlers.  See :
          #   http://ninenines.eu/docs/en/cowboy/HEAD/manual/cowboy_static/
          # Options is a tuple of { type, atom, string }.  In this case:
          #   :priv_dir              -- serve files from a directory
          #   :cowboy_elixir_example -- application name.  This is used to search for
          #                             the path that priv/ exists in.
          #   "static_files"         -- directory to look for files in 
          {"/static/[...]", :cowboy_static, {:priv_dir,  :cowboy_elixir_example, "static_files"}},

          # Serve a dynamic page with a custom handler
          # When a request is sent to "/dynamic", pass the request to the custom handler
          # defined in module DynamicPageHandler.
          {"/dynamic", DynamicPageHandler, []},

          # Serve websocket requests.
          {"/websocket", WebsocketHandler, []}
      ]}
    ])
    { :ok, _ } = :cowboy.start_http(:http, 
                                    100,
                                   [{:port, 8080}],  
                                   [{ :env, [{:dispatch, dispatch}]}]
                                   ) 

    #device = File.open!("dbg.log", [:write])
    #Application.put_env(:dbg, :device, device) 
    #IEx.configure([colors: [enabled: false]]) 
    #Dbg.reset                               
    #CowboyElixirExample.Supervisor.start_link([])
  end
end
