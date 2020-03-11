defmodule Stack_server.Server do
    use GenServer
    # EXTERNAL API
    def start_link(current_stack) do
        GenServer.start_link(__MODULE__, current_stack,name: __MODULE__)
    end
    def pop() do
        GenServer.call __MODULE__, :pop
    end
    def push (value) do
        GenServer.cast __MODULE__, {:push, value}
    end
    def status() do
        :sys.get_status __MODULE__ 
    end
    # IMPLEMENTATION
    defp pop_stack(stack) when stack != [] do
        {List.last(stack),List.delete_at(stack,-1)}
    end
    defp pop_stack(_) do
        {"Already Empty",[]}
    end
    defp push_stack(stack, value) do
        stack ++ [value]
    end
    #GenServer Implementation
    def init(initial_stack)do
        {:ok, initial_stack}
    end 
    def handle_call(:pop, _from, current_stack) do
        {deleted, new_stack} = pop_stack(current_stack)
        {:reply, deleted, new_stack}
    end 
    def handle_cast({:push, value}, current_stack) do
        {:noreply, push_stack(current_stack, value)}
    end
    def format_status(_reason, [_pdict, state]) do
        [data: [{'State',"Current state is: '#{inspect state}'"}]]
    end
    def terminate(reason,state) do
        IO.puts "Going down: #{inspect state}"
        :normal
    end
end