defmodule PetalWeb.LayoutView do
  use PetalWeb, :view

  @application :petal

  def title(_conn),
    do: Application.get_env(@application, :title, (System.get_env("TITLE") || "Phoenix Framework"))

  def manifest(_conn),
    do: Routes.static_url(Web.Endpoint, "/manifest.json")

  def image("favicon", _conn),
    do: Routes.static_url(Web.Endpoint, "/favicon.ico")

  def image(image, _conn),
    do: Routes.static_url(Web.Endpoint, "/images/#{image}")

  def theme_color(assigns, _conn),
    do: assigns[:theme_color] || Application.get_env(@application, :theme_color, (System.get_env("THEME_COLOR") || "white"))

  def apple_mobile_web_app_status_bar_style(assigns, _conn),
    do: assigns[:apple_mobile_web_app_status_bar_style] || Application.get_env(@application, :apple_mobile_web_app_status_bar_style, (System.get_env("APPLE_MOBILE_WEB_APP_STATUS_BAR_STYLE") || "default"))

  def msapplication_tilecolor(assigns, _conn),
    do: assigns[:msapplication_tilecolor] || Application.get_env(@application, :msapplication_tilecolor, (System.get_env("MSAPPLICATION_TILECOLOR") || "white"))

  def og(:title, assigns, conn),
    do: assigns[:og_title] || Application.get_env(@application, :og_title, (System.get_env("OG_TITLE") || title(conn)))

  def og(:description, assigns, _conn),
    do: assigns[:og_description] || Application.get_env(@application, :og_description, (System.get_env("OG_DESCRIPTION") || "Peace of mind from prototype to production"))

  def og(:image, assigns, _conn),
    do: assigns[:og_image] || Routes.static_url(Web.Endpoint, "/images/og_image.png")

  def og(:url, assigns, _conn),
    do: assigns[:og_url] || Routes.static_url(Web.Endpoint, "/")

  def language(_conn),
    do: Application.get_env(@application, :language, (System.get_env("LANGUAGE") || "en"))

end
