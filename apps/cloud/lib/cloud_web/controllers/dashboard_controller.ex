defmodule CloudWeb.DashboardController do
  use CloudWeb, :controller
  alias Cloud.Guardian.Plug
  alias Cloud.Scenario

  def index(conn, _params) do
    resource = Plug.current_resource(conn)

    files =
      List.first(resource.organizations).id |> Scenario.get_scenes_files_by_organization_id()

    render(conn, "index.html", files: files)
  end
end
