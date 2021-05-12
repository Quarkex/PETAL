defmodule PetalWeb do
  @moduledoc """
  The entrypoint for defining your web interface, such
  as controllers, views, channels and so on.

  This can be used in your application as:

      use PetalWeb, :controller
      use PetalWeb, :view

  The definitions below will be executed for every view,
  controller, etc, so keep them short and clean, focused
  on imports, uses and aliases.

  Do NOT define functions inside the quoted expressions
  below. Instead, define any helper function in modules
  and import those modules here.
  """

  def controller do
    quote do
      use Phoenix.Controller, namespace: PetalWeb

      @application :petal
      alias Petal, as: App
      alias PetalWeb, as: Web

      import Plug.Conn
      import Web.Gettext
      alias Web.Router.Helpers, as: Routes
    end
  end

  def view do
    quote do
      use Phoenix.View,
        root: "lib/petal_web/templates",
        namespace: PetalWeb

      @application :petal
      alias Petal, as: App
      alias PetalWeb, as: Web

      # Import convenience functions from controllers
      import Phoenix.Controller,
        only: [get_flash: 1, get_flash: 2, view_module: 1, view_template: 1]

      # Include shared imports and aliases for views
      unquote(view_helpers())
    end
  end

  def live_view do
    quote do
      use Phoenix.LiveView,
        layout: {PetalWeb.LayoutView, "live.html"}

      def mount(params, %{"user_token" => user_token} = session, socket),
        do: mount(params,
        Map.delete(session, "user_token"),
        assign(socket, :current_user, Petal.Accounts.get_user_by_session_token(user_token))
      )

      unquote(view_helpers())
    end
  end

  def live_component do
    quote do
      use Phoenix.LiveComponent
      unquote(view_helpers())
    end
  end

  def router do
    quote do
      use Phoenix.Router

      @application :petal
      alias Petal, as: App
      alias PetalWeb, as: Web

      import Plug.Conn
      import Phoenix.Controller
      import Phoenix.LiveView.Router
    end
  end

  def channel do
    quote do
      use Phoenix.Channel
      @application :petal
      alias Petal, as: App
      alias PetalWeb, as: Web
      import Web.Gettext
    end
  end

  defp view_helpers do
    quote do
      # Use all HTML functionality (forms, tags, etc)
      use Phoenix.HTML

      @application :petal
      alias Petal, as: App
      alias PetalWeb, as: Web

      # Import LiveView helpers (live_render, live_component, live_patch, etc)
      import Phoenix.LiveView.Helpers

      # Import basic rendering functionality (render, render_layout, etc)
      import Phoenix.View

      import Web.ErrorHelpers
      import Web.Gettext
      alias Web.Router.Helpers, as: Routes
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
