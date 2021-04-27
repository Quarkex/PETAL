defmodule PruebaWeb.ManifestController do
  use PruebaWeb, :controller

  def index(conn, _params) do
    {code, payload} = manifest()
                      |> Jason.encode()
                      |> case do
                        {:ok, json} -> {200, json}
                        _ -> {500, ~w[{"status": "error"}]}
                      end
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(code, payload)
  end

  defp manifest() do
    ~w{
      name
      short_name
      icons
      lang
      start_url
      display
      background_color
      theme_color
    }a
    |> Enum.map(fn a -> {a, manifest(a)} end)
    |> Map.new
  end

  defp manifest(:name),
  do: manifest(:name, :title, manifest(:domain))

  defp manifest(:short_name),
  do: manifest(:name)

  defp manifest(:start_url),
  do: "https://" <> manifest(:domain)

  defp manifest(:display),
  do: manifest(:display, "standalone")

  defp manifest(:background_color),
  do: manifest(:background_color, "white")

  defp manifest(:theme_color),
  do: manifest(:theme_color, "white")

  defp manifest(:icons) do
    icons = Application.get_env(@application, Web.Endpoint)[:icons] || ~w{ 512 256 384 192 152 144 128 96 72 48 }
    cond do
      is_list(icons) && Enum.any?(icons, &is_map/1) ->
        icons
      true ->
        Enum.map(icons, fn s ->
          %{
            src: "img/logo-#{s}.png",
            sizes: "#{s}x#{s}",
            type: "image/png"
          }
        end) ++ [
          %{
            src: "img/logo.svg",
            sizes: icons
                   |> Enum.map(fn s -> "#{s}x#{s}" end)
                   |> Enum.join(" "),
            purpose: "maskable any",
            type: "image/svg"
          }
        ]
    end
  end

  defp manifest(:lang),
  do: Application.get_env(@application, Web.Gettext)[:default_locale] || "en"

  defp manifest(:domain),
  do: Application.get_env(@application, Web.Endpoint)[:url][:host] || "localhost"

  defp manifest(attribute, default),
  do: Application.get_env(@application, Web.Endpoint)[attribute] || default

  defp manifest(_name, attribute, default),
  do: Application.get_env(@application, Web.Endpoint)[attribute] || default

end
