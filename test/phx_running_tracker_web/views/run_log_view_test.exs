defmodule PhxRunningTrackerWeb.RunLogViewTest do
  use PhxRunningTrackerWeb.ConnCase, async: true

  alias PhxRunningTrackerWeb.RunLogView

  test "formats run_log pace" do
    formatted = RunLogView.format_pace({ 3, 25, 14, 22 })
    assert formatted == "03:25:14"
  end
end
