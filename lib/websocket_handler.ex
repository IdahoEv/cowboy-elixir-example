defmodule WebsocketHandler do
  @behaviour :cowboy_websocket_handler

  def init({tcp, http}, _req, _opts) do
    {:upgrade, :protocol, :cowboy_websocket}
  end

  def websocket_init(_TransportName, req, _opts) do
    IO.puts "init.  Starting timer. PID is #{inspect(self())}"
    :erlang.start_timer(1000, self(), [])
    {:ok, req, :undefined_state }
  end

  def websocket_handle(message, req, state) do
    IO.puts "Received message: #{inspect(message)}"
  end

  def websocket_terminate(_reason, _req, _state) do
    :ok
  end

  def websocket_info({timeout, _ref, _foo}, req, state) do
    {hh,mm,ss} = :erlang.time()
    time = "#{hh}:#{mm}:#{ss}"
    message = "{ \"time\": \"#{time}\" }"
    IO.puts("Message: #{message}")
    :erlang.start_timer(1000, self(), [])
    { :reply, {:text, message}, req, state}
  end

  def websocket_info(_info, req, state) do
    {:ok, req, state}
  end

end

