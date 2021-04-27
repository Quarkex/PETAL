defmodule PruebaWeb.AssetLinksController do

  @application :localhost
  alias PruebaWeb, as: Web

  use Web, :controller

  def index(conn, _params) do
    {code, payload} = asset_links()
                      |> Jason.encode()
                      |> case do
                        {:ok, json} -> {200, json}
                        _ -> {500, ~w[{"status": "error"}]}
                      end
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(code, payload)
  end

  defp asset_links() do
    ~w{
      relation
      target
      sha256_cert_fingerprints
    }a
    |> Enum.map(fn a -> {a, asset_links(a)} end)
    |> Map.new
  end

  defp asset_links(:target),
  do: %{
    namespace: asset_links(:apk_namespace, "android_app"),
    target: asset_links(:apk_package_name, "tld.domain.apk")
  }

  defp asset_links(:relation),
  do: :apk_relation
      |> asset_links("delegate_permission/common.handle_all_urls")
      |> String.split(",")

  defp asset_links(:sha256_cert_fingerprints),
  do: :apk_sha256_cert_fingerprints
      |> asset_links("00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00")
      |> String.split(",")

  defp asset_links(attribute, default_value),
  do: Application.get_env(@application, Web.Endpoint)[attribute] || default_value
end
