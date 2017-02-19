defmodule CuratorApprovable.ConfigTest do
  use ExUnit.Case, async: true
  doctest CuratorApprovable.Config

  test "the repo" do
    assert CuratorApprovable.Config.repo == CuratorApprovable.Test.Repo
  end

  test "the user_schema" do
    assert CuratorApprovable.Config.user_schema == CuratorApprovable.Test.User
  end
end
