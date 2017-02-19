defmodule CuratorApprovable.Config do
  @moduledoc """
  The configuration for CuratorApprovable.

  ## Configuration

      config :curator_approvable, CuratorApprovable,
        repo: CuratorApprovable.Test.Repo,
        user_schema: CuratorApprovable.Test.User

  """
  def repo do
    config(:repo, Curator.Config.repo)
  end

  def user_schema do
    config(:user_schema, Curator.Config.user_schema)
  end

  @doc false
  def config, do: Application.get_env(:curator_approvable, CuratorApprovable, [])
  @doc false
  def config(key, default \\ nil),
    do: config() |> Keyword.get(key, default) |> resolve_config(default)

  defp resolve_config({:system, var_name}, default),
    do: System.get_env(var_name) || default
  defp resolve_config(value, _default),
    do: value
end
