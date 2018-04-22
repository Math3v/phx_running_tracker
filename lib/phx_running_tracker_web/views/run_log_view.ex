defmodule PhxRunningTrackerWeb.RunLogView do
  use PhxRunningTrackerWeb, :view

  def format_pace({ hours, minutes, seconds, _ms }) do
    "#{pad_time(hours)}:#{pad_time(minutes)}:#{pad_time(seconds)}"
  end

  defp pad_time(value) do
    value
    |> Integer.to_string
    |> String.pad_leading(2, "0")
  end
end
