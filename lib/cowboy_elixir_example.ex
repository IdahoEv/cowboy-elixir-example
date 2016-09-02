defmodule CowboyElixirExample do

  @doc """
  Start up a cowboy http server.  The start_http method of cowboy takes
  four arguments:
    * The protocol of the server
    * "NbAcceptors" - a non-negative-integer. This isn't further documented in
      the cowboy docs.  I used 100, from an Erlang example.
    * TCP options for Ranch as a list of tuples.  In this case the one one
      we are using is :port, to set the server listening on port 8080.
      You could also, for example, set ipv6, timeouts, and a number of other things here.
      SEE ALSO: http://ninenines.eu/docs/en/ranch/1.2/manual/ranch_tcp/
    * Protocol options for cowboy as a list of tuples.  This can be a very big
      structure because it includes you "middleware environment", which among
      other things includes your entire routing table. Here that is the only option
      we are specifying.
      SEE ALSO: http://ninenines.eu/docs/en/cowboy/1.0/manual/cowboy_protocol/

  SEE ALSO: http://ninenines.eu/docs/en/cowboy/1.0/guide/getting_started/
  """
  def start(_type, _args) do
    dispatch_config = build_dispatch_config
    { :ok, _ } = :cowboy.start_http(:http,
                                    100,
                                   [{:port, 8080}],
                                   [{ :env, [{:dispatch, dispatch_config}]}]
                                   )

  end

  @doc """
  The dispatch configuration specifies your routing table: how incoming
  URLs are mapped to the Module and function that should get run for that
  request.  It's built with the `:cowboy_router.compile` function, which
  takes a list of tuples.  Each tuple specifies a hostname (or wildcard)
  that can match, and the options -- including routes -- for that hostname.

  Each route is a tuple of the form `{ PathMatch, Handler, Options}`.

  Individual components of the configuration are documented in comments
  line-by-line in the code below.

  SEE ALSO: http://ninenines.eu/docs/en/cowboy/1.0/guide/routing/
  """
  def build_dispatch_config do

    # Compile takes as argument a list of tuples that represent hosts to
    # match against.So, for example if your DNS routed two different
    # hostnames to the same server, you could handle requests for those
    # names with different sets of routes. See "Compilation" in:
    #      http://ninenines.eu/docs/en/cowboy/1.0/guide/routing/
    :cowboy_router.compile([

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
          #   http://ninenines.eu/docs/en/cowboy/1.0/manual/cowboy_http_handler//manual/cowboy_static/
          # Options is a tuple of { type, atom, string }.  In this case:
          #   :priv_file             -- serve a single file
          #   :cowboy_elixir_example -- application name.  This is used to search for
          #                             the path that priv/ exists in.
          #   "index.html            -- filename to serve
          {"/", :cowboy_static, {:priv_file, :cowboy_elixir_example, "index.html"}},


          # Serve all static files in a directory.
          # PathMatch is "/static/[...]" -- string at [...] will be used to look up the file
          # Handler is :cowboy_static -- one of cowboy's built-in handlers.  See :
          #   http://ninenines.eu/docs/en/cowboy/1.0/manual/cowboy_http_handler//manual/cowboy_static/
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
  end
end
