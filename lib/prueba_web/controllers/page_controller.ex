defmodule PruebaWeb.PageController do
  use PruebaWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
