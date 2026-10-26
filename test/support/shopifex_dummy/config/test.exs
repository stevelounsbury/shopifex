import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
#
# SHOPIFEX_DB=sqlite runs the suite against SQLite instead of Postgres.
case System.get_env("SHOPIFEX_DB", "postgres") do
  "postgres" ->
    config :shopifex, :dummy_repo_adapter, Ecto.Adapters.Postgres

    config :shopifex, ShopifexDummy.Repo,
      username: "postgres",
      password: "postgres",
      database: "shopifex_dummy_test#{System.get_env("MIX_TEST_PARTITION")}",
      hostname: "localhost",
      pool: Ecto.Adapters.SQL.Sandbox

  "sqlite" ->
    config :shopifex, :dummy_repo_adapter, Ecto.Adapters.SQLite3

    config :shopifex, ShopifexDummy.Repo,
      database:
        Path.expand(
          "../../../../_build/shopifex_dummy_test#{System.get_env("MIX_TEST_PARTITION")}.db",
          __DIR__
        ),
      pool: Ecto.Adapters.SQL.Sandbox
end

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :shopifex, ShopifexDummyWeb.Endpoint,
  http: [port: 4002],
  server: false

config :shopifex,
  app_name: "Shopifex Dummy",
  shop_schema: ShopifexDummy.Shop,
  payment_guard: ShopifexDummy.Shops.PaymentGuard,
  grant_schema: ShopifexDummy.Shops.Grant,
  plan_schema: ShopifexDummy.Shops.Plan,
  repo: ShopifexDummy.Repo,
  web_module: ShopifexDummyWeb,
  scopes: "orders",
  webhook_topics: ["app/uninstalled", "orders/create", "carts/update"],
  payment_redirect_uri: "https://shopifex-dummy.com/payment/complete",
  redirect_uri: "https://shopifex-dummy.com/auth/install",
  reinstall_uri: "https://shopifex-dummy.com/auth/update",
  webhook_uri: "https://shopifex-dummy.com/webhook",
  api_key: "thisisafakeapikey",
  secret: "shpss_thisisafakesecret"

# Print only warnings and errors during test
config :logger, level: :warning
