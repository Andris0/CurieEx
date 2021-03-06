defmodule Curie.Commands do
  @moduledoc """
  Helper for command modules.
  """

  alias Nostrum.Struct.Message

  @type command_call :: {String.t(), Message.t(), [String.t()]}
  @type words_to_check :: String.t() | [String.t()]

  @callback command(command_call) :: any

  @prefix Application.compile_env(:curie, :prefix)

  @spec __using__(any) :: any
  defmacro __using__(_opts) do
    quote location: :keep do
      alias unquote(__MODULE__)

      @behaviour unquote(__MODULE__)
      @super unquote(__MODULE__)

      @owner %{author: %{id: Application.compile_env(:curie, :owner)}}
      @tempest Application.compile_env(:curie, :tempest)
      @prefix Application.compile_env(:curie, :prefix)

      @spec command(@super.command_call) :: any
      def command(_command_call), do: :pass

      defoverridable command: 1
    end
  end

  @spec command?(Message.t()) :: boolean
  def command?(%{content: @prefix <> _content}), do: true
  def command?(_not_a_command), do: false

  @spec parse(Message.t()) :: command_call
  def parse(%{content: content} = message) do
    [@prefix <> call | args] = String.split(content, ~r(\s))
    call = String.downcase(call)
    {call, message, args}
  end

  @spec check_typo(command_call, words_to_check, function) :: any
  def check_typo({call, message, args}, check, caller) do
    case Curie.check_typo(call, check) do
      match when match not in [call, nil] -> caller.({match, message, args})
      _no_match -> :pass
    end
  end
end
