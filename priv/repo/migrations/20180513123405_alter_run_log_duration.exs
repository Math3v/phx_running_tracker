defmodule PhxRunningTracker.Repo.Migrations.AlterRunLogDuration do
  use Ecto.Migration

  def change do
    alter table("run_logs") do
      add :hours,   :integer
      add :minutes, :integer
      add :seconds, :integer

      remove :duration
    end
  end
end
