defmodule StackServer.Server do
    use GenServer
    # EXTERNAL API
    def start_link(current_stack) do
        GenServer.start_link(__MODULE__, nil, name: __MODULE__)
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
    defp pop_stack(stack) do
        []
    end
    defp push_stack(stack, value) do
        stack ++ [value]
    end
    #GenServer Implementation
    def init(initial_stack)do
        {:ok, StackServer.Stash.get()}
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
    def terminate(_reason,current_stack) do
        StackServer.Stash.update(current_stack)
    end
end

#EXERCISE_1
# The Server restarts after the crash, after the restart the stack
# contains the initial value determined at the application file
# Stack = ["cat"]