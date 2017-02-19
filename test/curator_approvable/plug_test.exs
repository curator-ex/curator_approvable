defmodule CuratorApprovable.PlugTest do
  use ExUnit.Case, async: true
  doctest CuratorApprovable.Plug

  use Plug.Test

  import CuratorApprovable.Test.PlugHelper

  setup do
    conn = conn_with_fetched_session(conn(:get, "/"))
    {:ok, %{conn: conn}}
  end

  test "with an inactive user", %{conn: conn} do
    user = %{approval_status: "pending"}

    conn = conn
    |> Guardian.Plug.set_claims({:ok, %{claims: "default"}})
    |> Curator.PlugHelper.set_current_resource(user)
    |> run_plug(CuratorApprovable.Plug)

    refute Curator.PlugHelper.current_resource(conn)
    assert Guardian.Plug.claims(conn, :default) == {:error, "Not Approved"}
  end

  test "with an active user", %{conn: conn} do
    user = %{approval_status: "approved"}

    conn = conn
    |> Guardian.Plug.set_claims({:ok, %{claims: "default"}})
    |> Curator.PlugHelper.set_current_resource(user)
    |> run_plug(CuratorApprovable.Plug)

    assert Curator.PlugHelper.current_resource(conn)
    assert Guardian.Plug.claims(conn) == {:ok, %{claims: "default"}}
  end

  test "with no user", %{conn: conn} do
    conn = conn
    |> Guardian.Plug.set_claims({:ok, %{claims: "default"}})
    |> run_plug(CuratorApprovable.Plug)

    refute Curator.PlugHelper.current_resource(conn)
    assert Guardian.Plug.claims(conn) == {:ok, %{claims: "default"}}
  end
end
