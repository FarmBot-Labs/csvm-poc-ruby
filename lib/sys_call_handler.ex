defmodule Csvm.SysCallHandler do
  @type return_value :: :ok | {:error, String.t()}
  @type sys_call_fun :: (atom, [any] -> return_value)

  @spec apply_sys_call_fun(sys_call_fun, atom, map) :: return_value | no_return
  def apply_sys_call_fun(fun, kind, args)
      when is_function(fun) and is_atom(kind) and is_map(args) do
    case apply(fun, [kind, args]) do
      :ok -> :ok
      {:error, return} when is_binary(return) -> {:error, return}
      other -> raise("Bad return value: #{inspect(other)}")
    end
  end
end
