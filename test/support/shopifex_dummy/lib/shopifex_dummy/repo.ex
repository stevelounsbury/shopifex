defmodule ShopifexDummy.Repo do
  use Ecto.Repo,
    otp_app: :shopifex,
    adapter: Application.compile_env(:shopifex, :dummy_repo_adapter, Ecto.Adapters.Postgres)
end
