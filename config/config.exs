use Mix.Config

config :ecto_lock, EctoLock.Repo,
  database: "ecto_lock_repo",
  hostname: "localhost"

config :ecto_lock, ecto_repos: [EctoLock.Repo]
