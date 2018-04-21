defmodule PhxRunningTracker.Accounts.RunLog do
  use Ecto.Schema
  import Ecto.Changeset


  schema "run_logs" do
    field :at_time, :time
    field :distance, :decimal
    field :duration, :integer
    field :note, :string
    field :on_date, :date

    timestamps()
  end

  @doc false
  def changeset(run_log, attrs) do
    run_log
    |> cast(attrs, [:distance, :on_date, :at_time, :duration, :note])
    |> validate_required([:distance, :on_date, :at_time, :duration, :note])
  end
end
