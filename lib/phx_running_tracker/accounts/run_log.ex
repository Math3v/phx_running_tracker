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

  @doc false
  def duration_to_attrs(%{hours: hours, minutes: minutes, seconds: seconds} = attrs) do
    duration = {hours, minutes, seconds, 0}
    |> Timex.Duration.from_clock
    |> Timex.Duration.to_milliseconds
    |> round

    attrs
    |> Map.put(:duration, duration)
    |> Map.drop([:hours, :minutes, :seconds])
  end

  # TODO: Shouldn't be used
  def duration_to_attrs(attrs) do
    attrs
  end
end
