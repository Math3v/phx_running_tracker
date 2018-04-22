defmodule PhxRunningTrackerWeb.RunLogView do
  use PhxRunningTrackerWeb, :view

  def format_pace({ hours, minutes, seconds, _ms }) do
    "#{time_pad(hours)}:#{time_pad(minutes)}:#{time_pad(seconds)}"
  end

  defp time_pad(value) do
    value
    |> Integer.to_string
    |> String.pad_leading(2, "0")
  end
end
