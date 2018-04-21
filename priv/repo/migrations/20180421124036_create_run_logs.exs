defmodule PhxRunningTracker.Repo.Migrations.CreateRunLogs do
  use Ecto.Migration

  def change do
    create table(:run_logs) do
      add :distance, :decimal
      add :on_date, :date
      add :at_time, :time
      add :duration, :integer
      add :note, :string

      timestamps()
    end

  end
end
