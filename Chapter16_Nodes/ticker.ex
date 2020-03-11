defmodule Ticker do
    @internal 2000 # 2 seconds
    @name     :ticker

    def start do
        pid = spawn(__MODULE__, :generator, [[]])
        :global.register_name(@name, pid)
    end

    def register(client_pid) do
        send :global.whereis_name(@name), { :register, client_pid }
    end

    def generator(clients) do
        receive do
            { :register, pid } ->
                IO.puts "registering #{inspect pid}"
                generator([ pid | clients ])
            after @internal ->
                IO.puts "tick"
                Enum.each clients, fn client ->
                    send client, { :tick }end
                generator(clients)
        end
    end
end

defmodule Ticker_3 do
    @internal 2000 # 2 seconds
    @name     :ticker

    def start do
        {:ok, _agent} = Agent.start_link(fn -> 1 end)
        pid = spawn(__MODULE__, :generator, [[]])
        :global.register_name(@name, pid)
    end

    def register(client_pid) do
        send :global.whereis_name(@name), { :register, client_pid }
    end

    def generator(agent, clients) do
        receive do
            { :register, pid } ->
                IO.puts "registering #{inspect pid}"
                generator(agent, clients ++ [pid])
            after @internal ->
                IO.puts "tick"
                n = Agent.get(agent, fn n -> n end)
                handle_tick(agent, clients, n)
        end
    end
    defp handle_tick(agent, clients, _) when clients == [] do
        IO.puts "No clients"
        generator(agent, clients)
    end
    defp handle_tick(agent, clients, n) when n > length(clients) do
        #Back to first client
        handle_tick(agent, clients, 1)
    end
    defp handle_tick(agent, clients, n) do
        IO.puts "Hey client No.#{n}"
        Enum.at(clients, n-1)
            |> send ({:tick, n})
        Agent.update(agent, fn _ -> n+1 end)
        generator(agent,clients)
    end
end

defmodule Ticker_4 do
    @internal 2000 # 2 seconds
    @name     :ticker

    def start do
        {:ok, agent} = Agent.start_link(fn -> 1 end)
        status = :global.register_name(@name, agent)
        process(status, agent)
    end
    defp process(:no, agent) do
        Agent.stop(agent)
        agent = :global.whereis_name(@name)
        IO.puts "Agent retriece : #{inspect agent}"
        register_client(agent)
    end
    defp process(:yes, agent) do
        IO.puts "Agent registered"
        register_client(agent)
    end
    def register_client(agent) do
        me = self()
        IO.puts "Registering client #{inspect me}"
        client_num = Agent.get_and_update(agent, fn clients -> {length(clients),clients++[me]}end)
        if client_num == 0 do
            send me, {:tick}
        end
        tick(agent, me)
    end
    def tick(agent, pid) do
        receive do
            {:tick} ->
                clients = Agent.get(agent, fn c -> c end)
                idx = Enum.find_index(clients, fn p -> p ==pid end)
                IO.puts "tock in client No.#{idx+1}"
                :timer.sleep(@internal)
                notify_next(clients,idx+1)
                tick(agent, pid)
            after @internal ->
                IO.puts "Kept Waiting Notification"
                tick(agent, pid)
        end
    end
    defp notify_next(clients, idx) when idx ==0 or idx >= length(clients) do
        IO.puts "Notifying client 1"
        send Enum.at(clients,0), {:tick}
    end
    defp notify_next(clients, idx) do
        IO.puts "Notifying client #{idx+1}"
        send Enum.at(clients, idx), {:tick}
    end
end

defmodule Client do
    def start do
        pid = spawn(__MODULE__, :receiver, []) 
        Ticker.register(pid)
    end
    def receiver do 
        receive do
            { :tick, n} ->
                IO.puts "Im the client No.#{n}" 
                receiver()
        end 
    end
end

# New Clients can be added at any time, the client will w8 in the line to get called.
# Every client is responsible to update his link, this means that if a process dies
# then the process will die too. Thats because the previous process to the one that
# wont be able to tick the next one