defmodule CuratorApprovable do
  @moduledoc """
  CuratorApprovable: A curator module to handle user "approval".
  """

  if !(
       (Application.get_env(:curator_approvable, CuratorApprovable) && Keyword.get(Application.get_env(:curator_approvable, CuratorApprovable), :repo)) ||
       (Application.get_env(:curator, Curator) && Keyword.get(Application.get_env(:curator, Curator), :repo))
      ), do: raise "CuratorApprovable requires a repo"

  if !(
       (Application.get_env(:curator_approvable, CuratorApprovable) && Keyword.get(Application.get_env(:curator_approvable, CuratorApprovable), :user_schema)) ||
       (Application.get_env(:curator, Curator) && Keyword.get(Application.get_env(:curator, Curator), :user_schema))
      ), do: raise "CuratorApprovable requires a user_schema"

  alias CuratorApprovable.Config

  def approved?(user) do
    user.approval_status == "approved"
  end

  def approve!(user, approver_id \\ 0) do
    user
    |> Config.user_schema.approvable_changeset(%{approval_at: Timex.now, approval_status: "approved", approver_id: approver_id})
    |> Config.repo.update!
  end

  def active_for_authentication?(resource) do
    case approved?(resource) do
      true -> :ok
      false -> {:error, "Not Approved"}
    end
  end
end
