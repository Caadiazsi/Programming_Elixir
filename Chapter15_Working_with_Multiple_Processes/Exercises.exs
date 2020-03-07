defmodule  Exercises do
    # EXERCISE_2
    def token_function() do
        :timer.sleep(Enum.random(10..1000))
        receive do
            {sender, token} ->
                send sender, {:ok, "A token arrived: #{token}"}
                token_function()
        end
    end
    defp spawning(token) do
        pid = spawn(Exercises, :token_function, [])
        send pid, {self(),token}
    end
    def run_tokens(tokens) do
        Enum.each(tokens, &(spawning(&1)))
        Enum.each(tokens, fn _ -> 
            receive do
                {:ok, message} ->
                    IO.puts "#{message} at #{Time.utc_now()}."
            end
        end)
    end
    # EXERCISE_3
    def child_ex3(parent_pid) do
        send parent_pid, {:ok ,"My job here is done!"}
        exit(:bye)
    end
    def exercise_3() do
        spawn_link(Spawn, :child_ex3, [self()])
        :timer.sleep(500)
        receive do
            {:ok, message} -> IO.puts message
        end
    end
    # EXERCISE_4
    def child_ex4(parent_pid) do
        send parent_pid, {:ok ,"My job here is done!"}
        raise("Smoke Bomb!")
    end
    def exercise_4() do
        spawn_link(Spawn, :child_ex4, [self()])
        :timer.sleep(500)
        receive do
            {:ok, message} -> IO.puts message
        end
    end
    # EXERCISE_5
    def monitor_exercise_3() do
        spawn_monitor(Spawn, :child_exit, [self()])
        :timer.sleep(500)
        receive do
            msg -> IO.puts inspect msg
        end
    end
    def monitor_exercise_4() do
        spawn_monitor(Spawn, :child_exception, [self()])
        :timer.sleep(500)
        receive do
            msg -> IO.puts msg
        end
    end
    # EXERCISE_6
    def pmap_6(collection, fun) do
        me = self()
        collection
            |> Enum.map(fn (elem) ->
                    spawn_link fn ()-> (send me, { self(), fun.(elem) }) end
                end)
            |> Enum.map(fn (pid) ->
                    receive do { ^pid, result } -> result end
                end)
    end
    # EXERCISE_7
    def pmap_7(collection, fun) do
        me = self()
        collection
            |> Enum.map(fn (elem) ->
                    spawn_link fn ()-> 
                        :timer.sleep(Enum.random(10..1000))
                        (send me, { self(), fun.(elem) }) 
                    end
                end)
            |> Enum.map(fn (_) ->
                    receive do { _pid, result } -> result end
                end)
    end
end
#EXERCISE_8
defmodule FibSolver do
    def fib(scheduler) do
        send scheduler, { :ready, self() }
        receive do
            { :fib, n, client } ->
                send client, { :answer, n, fib_calc(n), self() }
                fib(scheduler)
            { :shutdown } ->
                exit(:normal)
        end
    end

    defp fib_calc(0), do: 0
    defp fib_calc(1), do: 1
    defp fib_calc(n), do: fib_calc(n - 1) + fib_calc(n - 2)
end
# EXERCISE_8
defmodule Scheduler do
    def run(num_processes, module, func, to_calculate) do
        (1..num_processes)
            |> Enum.map(fn(_) -> spawn(module, func, [self()]) end)
            |> schedule_processes(to_calculate, [])
    end

    def schedule_processes(processes, queue, results) do
        receive do
        { :ready, pid } when queue != [] ->
            [ next | tail ] = queue
            send pid, { :fib, next, self() }
            schedule_processes(processes, tail, results)
        { :ready, pid } ->
            send pid, { :shutdown }
            if length(processes) > 1 do
                schedule_processes(List.delete(processes, pid), queue, results)
            else
                Enum.sort(results, fn { n1, _ }, { n2, _ } -> n1 <= n2 end)
            end
        { :answer, number, result, _pid} ->
            schedule_processes(processes, queue, [ { number, result } | results ])
        end
    end
end
#EXERCISE_2
    Exercises.run_tokens(["Ana","Betty","Carla","Danny"])

    # In order to guarantee that the answers get in the order the tokens were sent
    # Pass de receive block from run_tokens to spawning.
    # This will cause that every new process wont be created unless the previous
    # process gets a message from token_function

#EXERCISE_3
    #Exercises.exercise_3()
    # If the main process is sleeping the message gets lost
    # otherwise it will sometimes get it and sometimes wont.

#EXERCISE_4
    #Exercises.exercise_4()
    #It does not matter if the main process is sleeping or not
    #The exception will always break the run

#EXERCISE_5
    #Exercises.monitor_exercise_3()
    # Unlike exercise-3, even if not sleeping, the 
    # process seems to always receive child sent msg.
    #Exercises.monitor_exercise_4()
    # If sleep, the exception shut and then the message its send
    # If not sleep, exception wont shut

#EXERCISE_6
    # Every child process needs the parent pid in order to sent back the response
    # the parent pid gets saved in me, if sel() gets passed instead of me
    # the childs will get their own pid as the parent pid

#EXERCISE_7
    # A random sleep is added in order to see the bug, the responses gets in a 
    # differente order that they were requested so the final list its not mapped
    # correctly.
    # Changing the function to the previous one will solve the problem.

#EXERCISE_8
    to_process = List.duplicate(37, 20)
    Enum.each 1..10, fn num_processes ->
        { time, result } = :timer.tc(Scheduler, :run, [ num_processes, FibSolver, :fib, to_process ])
        if num_processes == 1 do
            IO.puts inspect result
            IO.puts "\n #   time (s)"
        end
        :io.format "~2B   ~.2f~n", [ num_processes, time / 1000000.0 ]
    end

#EXERCISE_9



