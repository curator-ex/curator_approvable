defmodule CuratorApprovableTest do
  use ExUnit.Case
  doctest CuratorApprovable

  use CuratorApprovable.TestCase

  setup do
    changeset = User.changeset(%User{}, %{
      name: "Test User",
      email: "test_user@test.com",
    })

    user = Repo.insert!(changeset)

    { :ok, %{
        user: user,
      }
    }
  end

  test "approve", %{user: user} do
    user = CuratorApprovable.approve!(user)

    assert user.approval_status == "approved"
    assert user.approval_at
    assert user.approver_id == 0
  end

  test "active_for_authentication? with a pending user" do
    user = %{approval_status: "pending"}
    {:error, "Not Approved"} = CuratorApprovable.active_for_authentication?(user)
  end

  test "active_for_authentication? with an approved user" do
    user = %{approval_status: "approved"}
    :ok = CuratorApprovable.active_for_authentication?(user)
  end
end
