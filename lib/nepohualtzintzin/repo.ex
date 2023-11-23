defmodule Nepohualtzintzin.Repo do
  use Ecto.Repo,
    otp_app: :nepohualtzintzin,
    adapter: Ecto.Adapters.Postgres
end
