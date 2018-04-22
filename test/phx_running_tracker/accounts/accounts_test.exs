defmodule PhxRunningTracker.AccountsTest do
  use PhxRunningTracker.DataCase

  alias PhxRunningTracker.Accounts

  describe "run_logs" do
    alias PhxRunningTracker.Accounts.RunLog

    @valid_attrs %{at_time: ~T[14:00:00.000000], distance: "120.5", duration: 42, note: "some note", on_date: ~D[2010-04-17]}
    @update_attrs %{at_time: ~T[15:01:01.000000], distance: "456.7", duration: 43, note: "some updated note", on_date: ~D[2011-05-18]}
    @invalid_attrs %{at_time: nil, distance: nil, duration: nil, note: nil, on_date: nil}

    def run_log_fixture(attrs \\ %{}) do
      {:ok, run_log} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_run_log()

      run_log
    end

    test "list_run_logs/0 returns all run_logs" do
      run_log = run_log_fixture()
      assert Accounts.list_run_logs() == [run_log]
    end

    test "get_run_log!/1 returns the run_log with given id" do
      run_log = run_log_fixture()
      assert Accounts.get_run_log!(run_log.id) == run_log
    end

    test "create_run_log/1 with valid data creates a run_log" do
      assert {:ok, %RunLog{} = run_log} = Accounts.create_run_log(@valid_attrs)
      assert run_log.at_time == ~T[14:00:00.000000]
      assert run_log.distance == Decimal.new("120.5")
      assert run_log.duration == 42
      assert run_log.note == "some note"
      assert run_log.on_date == ~D[2010-04-17]
    end

    test "create_run_log/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_run_log(@invalid_attrs)
    end

    test "update_run_log/2 with valid data updates the run_log" do
      run_log = run_log_fixture()
      assert {:ok, run_log} = Accounts.update_run_log(run_log, @update_attrs)
      assert %RunLog{} = run_log
      assert run_log.at_time == ~T[15:01:01.000000]
      assert run_log.distance == Decimal.new("456.7")
      assert run_log.duration == 43
      assert run_log.note == "some updated note"
      assert run_log.on_date == ~D[2011-05-18]
    end

    test "update_run_log/2 with invalid data returns error changeset" do
      run_log = run_log_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_run_log(run_log, @invalid_attrs)
      assert run_log == Accounts.get_run_log!(run_log.id)
    end

    test "delete_run_log/1 deletes the run_log" do
      run_log = run_log_fixture()
      assert {:ok, %RunLog{}} = Accounts.delete_run_log(run_log)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_run_log!(run_log.id) end
    end

    test "change_run_log/1 returns a run_log changeset" do
      run_log = run_log_fixture()
      assert %Ecto.Changeset{} = Accounts.change_run_log(run_log)
    end

    test "computes basic run_log pace" do
      duration = 2
      |> Timex.Duration.from_hours
      |> Timex.Duration.to_milliseconds
      |> round

      run_log = run_log_fixture(%{ distance: "10.0", duration: duration })
      pace = Accounts.run_log_pace(run_log)
      assert pace == {0, 12, 0, 0}
    end

    test "computes complex run_log pace" do
      duration = 2.3
      |> Timex.Duration.from_hours
      |> Timex.Duration.to_milliseconds
      |> round

      run_log = run_log_fixture(%{ distance: "10.0", duration: duration })
      pace = Accounts.run_log_pace(run_log)
      assert pace == {0, 13, 48, 0}
    end
  end
end
