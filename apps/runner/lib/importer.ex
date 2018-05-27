defmodule Runner.Importer do
  @moduledoc """
  Dynamically import configured module into your module.
  ### Examples
      defmodule SomeModule do
        ...
        use MyApp.Importer
        ...
        def xyz do
          ...
          some_func_from_ref_module()
          ...
        end
      end
  """
  defmacro __using__(_) do
    quote do
      import unquote(Application.get_env(:my_app, :module_ref))
    end
  end
end
