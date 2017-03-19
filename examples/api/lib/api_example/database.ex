defmodule ApiExample.Database do
  use GenServer

  def start_link(state, opts \\ []) do
    GenServer.start_link(__MODULE__, state, opts)
  end

  def handle_cast({:add_user, user}, state) do
    case find_user(state.users, user["id"]) do
      :notfound -> {:noreply, %{state | users: [user] ++ state.users}}
      _ ->  {:noreply, state}
    end
  end

  def handle_call({:find_user, id}, _from, state) do
    {:reply, find_user(state.users, id), state}
  end

  def handle_call({:delete_user, id}, _from, state) do
    case  delete_user(state.users, [], id) do
      {:ok, users} -> {:reply, :ok, %{ state | users:  users}}
    end
  end

  def handle_call({:find_user, id}, _from, state) do
    {:reply, find_user(state.users, id), state}
  end

  def handle_call(:get_users, _from, state) do
    {:reply, state.users, state}
  end

  def find_user([head | tail], id) do
    case head["id"] == id do
      true -> head
      false -> find_user(tail, id)
    end
  end

  def find_user([], id) do
    :notfound        
  end

  def delete_user([head | tail], state, id) do
    case head["id"] == id do
      true -> delete_user(tail, state,  id)
      false -> delete_user(tail, [head] ++ state,  id)
    end
  end

  def delete_user([], state, id) do
    {:ok, state}    
  end
end
