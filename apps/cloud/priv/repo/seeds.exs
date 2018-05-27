alias Cloud.Auth.{User, Client, Authorization, Organization}
alias Cloud.Scenario.{SceneFile}
alias Comeonin.Bcrypt
alias Cloud.Repo

{:ok, content} = File.read("priv/repo/scene1.exs")

organization_1 =
  Repo.insert!(%Organization{
    name: "johndoe"
  })

user_1 =
  Repo.insert!(%User{
    username: "johndoe",
    email: "jdoe@slap.io",
    password_hash: Bcrypt.hashpwsalt("password"),
    enabled: true
  })

User.link_user_and_organization(user_1, organization_1)

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

Repo.insert!(%Authorization{
  client_id: client_1.id,
  user_id: user_1.id,
  code: "testcode"
})

Repo.insert!(%SceneFile{
  name: "scene1.exs",
  content: content,
  organization_id: organization_1.id
})
