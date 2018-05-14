defmodule PhxRunningTrackerWeb.RunLogController do
  use PhxRunningTrackerWeb, :controller

  alias PhxRunningTracker.Running
  alias PhxRunningTracker.Running.RunLog

  def index(conn, _params) do
    run_logs = Running.list_run_logs()
    render(conn, "index.html", run_logs: run_logs)
  end

  def new(conn, _params) do
    changeset = Running.change_run_log(%RunLog{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"run_log" => run_log_params}) do
    case Running.create_run_log(run_log_params) do
      {:ok, run_log} ->
        conn
        |> put_flash(:info, "Run log created successfully.")
        |> redirect(to: run_log_path(conn, :show, run_log))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    run_log = Running.get_run_log!(id)
    run_log_pace = Running.run_log_pace(run_log)
    render(conn, "show.html", run_log: run_log, pace: run_log_pace)
  end

  def edit(conn, %{"id" => id}) do
    run_log = Running.get_run_log!(id)
    changeset = Running.change_run_log(run_log)
    render(conn, "edit.html", run_log: run_log, changeset: changeset)
  end

  def update(conn, %{"id" => id, "run_log" => run_log_params}) do
    run_log = Running.get_run_log!(id)

    case Running.update_run_log(run_log, run_log_params) do
      {:ok, run_log} ->
        conn
        |> put_flash(:info, "Run log updated successfully.")
        |> redirect(to: run_log_path(conn, :show, run_log))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", run_log: run_log, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    run_log = Running.get_run_log!(id)
    {:ok, _run_log} = Running.delete_run_log(run_log)

    conn
    |> put_flash(:info, "Run log deleted successfully.")
    |> redirect(to: run_log_path(conn, :index))
  end
end
