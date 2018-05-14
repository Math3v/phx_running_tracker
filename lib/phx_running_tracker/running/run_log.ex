defmodule PhxRunningTracker.Running.RunLog do
  use Ecto.Schema
  import Ecto.Changeset


  schema "run_logs" do
    field :at_time, :time
    field :distance, :decimal
    field :note, :string
    field :on_date, :date
    field :hours, :integer
    field :minutes, :integer
    field :seconds, :integer

    timestamps()
  end

  @doc false
  def changeset(run_log, attrs) do
    run_log
    |> cast(attrs, [:distance, :on_date, :at_time, :note, :hours, :minutes, :seconds])
    |> validate_required([:distance, :on_date, :at_time, :note, :hours, :minutes, :seconds])
  end
end
