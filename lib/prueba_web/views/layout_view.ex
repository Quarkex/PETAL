defmodule PruebaWeb.LayoutView do
  use PruebaWeb, :view

  @application :prueba

  def title(_conn),
    do: Application.get_env(@application, :title, (System.get_env("TITLE") || "Phoenix Framework"))

  def language(_conn),
    do: Application.get_env(@application, :language, (System.get_env("LANGUAGE") || "en"))

end
