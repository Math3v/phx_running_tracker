defmodule PhxRunningTrackerWeb.PageController do
  use PhxRunningTrackerWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
