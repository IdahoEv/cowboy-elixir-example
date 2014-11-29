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

  def websocket_handle({:text, content}, req, state) do
    { :ok, body } = JSEX.decode(content)
    %{ "message" => message } = body
    IO.puts "Received message: #{message}"
    rev = String.reverse(message)
    IO.puts "Reversed message: #{rev}"
    { :ok, reply } = JSEX.encode(%{ "reply" => rev})
    IO.puts "Replying with: #{inspect(reply)}"
    {:reply, {:text, reply}, req, state}
  end
  
  def websocket_handle(_data, req, state) do    
    {:ok, req, state}
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

