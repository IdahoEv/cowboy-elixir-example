
defmodule DynamicPageHandler do
  @moduledoc """
  A cowboy handler for serving a single dynamic wepbage. No templates are used; the
  HTML is all generated within the handler.
  """

  @doc """
  inititalize a plain HTTP handler.  See the documentation here:
      http://ninenines.eu/docs/en/cowboy/1.0/manual/cowboy_http_handler/

  All cowboy HTTP handlers require an init() function, identifies which
  type of handler this is and returns an initial state (if the handler
  maintains state).  In a plain http handler, you just return a
  3-tuple with :ok.  We don't need to track a  state in this handler, so
  we're returning the atom :no_state.
  """
  def init(_type, req, []) do
    {:ok, req, :no_state}
  end

  @doc """
  Handle a single HTTP request.

  In a cowboy handler, the handle/2 function does the work. It should return
  a 3-tuple with :ok, a request object (containing the reply), and the current
  state.
  """
  def handle(request, state) do
    # construct a reply, using the cowboy_req:reply/4 function.
    #
    # reply/4 takes three arguments:
    #   * The HTTP response status (200, 404, etc.)
    #   * A list of 2-tuples representing headers
    #   * The body of the response
    #   * The original request
    { :ok, reply } = :cowboy_req.reply(

      # status code
      200,

      # headers
      [ {"content-type", "text/html"} ],

      # body of reply.
      build_body(request),

      # original request
      request
    )

    # handle/2 returns a tuple starting containing :ok, the reply, and the
    # current state of the handler.
    {:ok, reply, state}
  end


  @doc """
  Do any cleanup necessary for the termination of this handler.

  Usually you don't do much with this.  If things are breaking,
  try uncommenting the output lines here to get some more info on what's happening.
  """
  def terminate(_reason, _request, _state) do
    #IO.puts("Terminating for reason: #{inspect(reason)}")
    #IO.puts("Terminating after request: #{inspect(request)}")
    #IO.puts("Terminating with state: #{inspect(state)}")
    :ok
  end


  @doc """
  Assemble the body of a response in HTML.
  """
  def build_body(request) do
    """
    <html>
    <head>
      <title>Elixir Cowboy Dynamic Example</title>
      <link rel='stylesheet' href='/static/css/styles.css' type='text/css' />
    </head>
    <body>
      <div id='main'>
        <h1>Dynamic Page Example</h1>
        <p>This page is rendered via the route: <code>{"/dynamic", DynamicPageHandler, []}</code>
        <br/>
        and the code for the handler can be found in <code>lib/dynamic_page_handler.ex</code>.</p>

        <h2>Current Time (:erlang.now)</h2>
        <p><span class='time'> #{inspect(:erlang.now)}</span></p>
        <p>Reload this page to see the time change.</p>
        <h2>Your Request Headers</h2>
        <dl>#{dl_headers(request)}</dl>
      </div>
    </body>
    </html>
"""
  end

  @doc """
  Build the contents of a <dl> containing all the request headers.
  """
  def dl_headers(request) do
    {headers, _req2 } = :cowboy_req.headers(request)
    Enum.map(headers, fn item -> "<dt>#{elem(item, 0)}</dt><dd>#{elem(item, 1)}</dd>" end)
  end

end
