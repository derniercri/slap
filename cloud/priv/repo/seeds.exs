alias Cloud.Auth.Model.{User, Client, Authorization}
alias Comeonin.Bcrypt
alias Cloud.Repo

user_1 =
  Repo.insert!(%User{
    username: "johndoe",
    email: "jdoe@hibou.io",
    password_hash: Bcrypt.hashpwsalt("password"),
    enabled: true
  })

client_1 =
  Repo.insert!(%Client{
    name: "dev_client",
    secret: "secret",
    redirect_uri: "http://localhost"
  })

Repo.insert!(%Authorization{
  client_id: client_1.id,
  user_id: user_1.id,
  code: "testcode"
})
