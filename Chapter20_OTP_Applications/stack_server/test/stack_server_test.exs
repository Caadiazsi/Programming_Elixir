defmodule StackServerTest do
  use ExUnit.Case
  doctest StackServer

  test "greets the world" do
    assert StackServer.hello() == :world
  end
end
