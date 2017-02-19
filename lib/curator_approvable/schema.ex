defmodule CuratorApprovable.Schema do
  @moduledoc """
  """

  defmacro __using__(_opts \\ []) do
    quote do
      import unquote(__MODULE__)

      def approvable_changeset(model, params \\ %{}) do
        model
        |> cast(params, curator_approvable_fields)
        |> validate_inclusion(:approval_status, ["pending", "approved", "rejected", "revoked"])
      end

      def curator_approvable_fields do
        ~w(approval_status approval_at approver_id)
      end
    end
  end

  defmacro curator_approvable_schema do
    quote do
      field :approval_status, :string, default: "pending"
      field :approval_at, Timex.Ecto.DateTime
      field :approver_id, :integer
    end
  end
end
