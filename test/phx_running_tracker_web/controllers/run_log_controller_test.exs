defmodule PhxRunningTrackerWeb.RunLogControllerTest do
  use PhxRunningTrackerWeb.ConnCase

  alias PhxRunningTracker.Accounts

  @create_attrs %{at_time: ~T[14:00:00.000000], distance: "120.5", duration: 42, note: "some note", on_date: ~D[2010-04-17]}
  @update_attrs %{at_time: ~T[15:01:01.000000], distance: "456.7", duration: 43, note: "some updated note", on_date: ~D[2011-05-18]}
  @invalid_attrs %{at_time: nil, distance: nil, duration: nil, note: nil, on_date: nil}

  def fixture(:run_log) do
    {:ok, run_log} = Accounts.create_run_log(@create_attrs)
    run_log
  end

  describe "index" do
    test "lists all run_logs", %{conn: conn} do
      conn = get conn, run_log_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Run logs"
    end
  end

  describe "new run_log" do
    test "renders form", %{conn: conn} do
      conn = get conn, run_log_path(conn, :new)
      assert html_response(conn, 200) =~ "New Run log"
    end
  end

  describe "create run_log" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, run_log_path(conn, :create), run_log: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == run_log_path(conn, :show, id)

      conn = get conn, run_log_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Run log"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, run_log_path(conn, :create), run_log: @invalid_attrs
      assert html_response(conn, 200) =~ "New Run log"
    end
  end

  describe "edit run_log" do
    setup [:create_run_log]

    test "renders form for editing chosen run_log", %{conn: conn, run_log: run_log} do
      conn = get conn, run_log_path(conn, :edit, run_log)
      assert html_response(conn, 200) =~ "Edit Run log"
    end
  end

  describe "update run_log" do
    setup [:create_run_log]

    test "redirects when data is valid", %{conn: conn, run_log: run_log} do
      conn = put conn, run_log_path(conn, :update, run_log), run_log: @update_attrs
      assert redirected_to(conn) == run_log_path(conn, :show, run_log)

      conn = get conn, run_log_path(conn, :show, run_log)
      assert html_response(conn, 200) =~ "some updated note"
    end

    test "renders errors when data is invalid", %{conn: conn, run_log: run_log} do
      conn = put conn, run_log_path(conn, :update, run_log), run_log: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Run log"
    end
  end

  describe "delete run_log" do
    setup [:create_run_log]

    test "deletes chosen run_log", %{conn: conn, run_log: run_log} do
      conn = delete conn, run_log_path(conn, :delete, run_log)
      assert redirected_to(conn) == run_log_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, run_log_path(conn, :show, run_log)
      end
    end
  end

  defp create_run_log(_) do
    run_log = fixture(:run_log)
    {:ok, run_log: run_log}
  end
end
