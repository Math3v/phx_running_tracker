defmodule PhxRunningTrackerWeb.Router do
  use PhxRunningTrackerWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug PhxRunningTrackerWeb.Auth
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PhxRunningTrackerWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/run_logs", RunLogController
    resources "/users", UserController
  end

  # Other scopes may use custom stacks.
  # scope "/api", PhxRunningTrackerWeb do
  #   pipe_through :api
  # end
end
