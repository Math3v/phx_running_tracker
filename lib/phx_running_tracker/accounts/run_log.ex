defmodule PhxRunningTracker.Accounts.RunLog do
  use Ecto.Schema
  import Ecto.Changeset


  schema "run_logs" do
    field :at_time, :time
    field :distance, :decimal
    field :duration, :integer
    field :note, :string
    field :on_date, :date
    # TODO: Use virtual fields

    timestamps()
  end

  @doc false
  def changeset(run_log, attrs) do
    attrs = convert_human_time_to_duration(attrs)

    run_log
    |> cast(attrs, [:distance, :on_date, :at_time, :duration, :note])
    |> validate_required([:distance, :on_date, :at_time, :duration, :note])
  end

  # TODO: Refactor
  defp convert_human_time_to_duration(attrs = %{hours: hours, minutes: minutes, seconds: seconds}) when is_bitstring(hours) and is_bitstring(minutes) and is_bitstring(seconds) do
    { hours_i, _ } = Integer.parse(hours)
    { minutes_i, _ } = Integer.parse(minutes)
    { seconds_i, _ } = Integer.parse(seconds)

    duration = to_duration({hours_i, minutes_i, seconds_i, 0})

    attrs
    |> Map.put(:duration, duration)
    |> Map.drop([:hours, :minutes, :seconds])
  end

  # TODO: Refactor
  defp convert_human_time_to_duration(attrs = %{"hours" => hours, "minutes" => minutes, "seconds" => seconds}) when is_bitstring(hours) and is_bitstring(minutes) and is_bitstring(seconds) do
    { hours_i, _ } = Integer.parse(hours)
    { minutes_i, _ } = Integer.parse(minutes)
    { seconds_i, _ } = Integer.parse(seconds)

    duration = to_duration({hours_i, minutes_i, seconds_i, 0})

    attrs
    |> Map.put("duration", duration)
    |> Map.drop(["hours", "minutes", "seconds"])
  end

  defp convert_human_time_to_duration(attrs) do
    attrs
  end

  @doc false
  defp to_duration(duration) do
    duration
    |> Timex.Duration.from_clock
    |> Timex.Duration.to_milliseconds
    |> round
  end
end
