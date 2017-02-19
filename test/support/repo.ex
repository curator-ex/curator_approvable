defmodule CuratorApprovable.Test.Repo do
  use Ecto.Repo, otp_app: :curator_approvable

  def log(_cmd), do: nil
end
