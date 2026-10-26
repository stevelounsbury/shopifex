# SQLite allows one writer at a time and each sandboxed test holds its write
# transaction open, so async cases that write would hit "Database busy".
ExUnit.start(
  if(ShopifexDummy.Repo.__adapter__() == Ecto.Adapters.SQLite3, do: [max_cases: 1], else: [])
)

Ecto.Adapters.SQL.Sandbox.mode(ShopifexDummy.Repo, :manual)
