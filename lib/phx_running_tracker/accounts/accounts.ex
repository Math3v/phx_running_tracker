defmodule PhxRunningTracker.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias PhxRunningTracker.Repo

  alias PhxRunningTracker.Accounts.RunLog

  @doc """
  Returns the list of run_logs.

  ## Examples

      iex> list_run_logs()
      [%RunLog{}, ...]

  """
  def list_run_logs do
    Repo.all(RunLog)
  end

  @doc """
  Gets a single run_log.

  Raises `Ecto.NoResultsError` if the Run log does not exist.

  ## Examples

      iex> get_run_log!(123)
      %RunLog{}

      iex> get_run_log!(456)
      ** (Ecto.NoResultsError)

  """
  def get_run_log!(id), do: Repo.get!(RunLog, id)

  @doc """
  Creates a run_log.

  ## Examples

      iex> create_run_log(%{field: value})
      {:ok, %RunLog{}}

      iex> create_run_log(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_run_log(attrs \\ %{}) do
    %RunLog{}
    |> RunLog.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a run_log.

  ## Examples

      iex> update_run_log(run_log, %{field: new_value})
      {:ok, %RunLog{}}

      iex> update_run_log(run_log, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_run_log(%RunLog{} = run_log, attrs) do
    run_log
    |> RunLog.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a RunLog.

  ## Examples

      iex> delete_run_log(run_log)
      {:ok, %RunLog{}}

      iex> delete_run_log(run_log)
      {:error, %Ecto.Changeset{}}

  """
  def delete_run_log(%RunLog{} = run_log) do
    Repo.delete(run_log)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking run_log changes.

  ## Examples

      iex> change_run_log(run_log)
      %Ecto.Changeset{source: %RunLog{}}

  """
  def change_run_log(%RunLog{} = run_log) do
    RunLog.changeset(run_log, %{})
  end
end
