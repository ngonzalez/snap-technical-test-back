def create_user(params = {})
  attributes = params.with_indifferent_access.reverse_merge(
    email: "fake.email@example.com",
    token: "this-is-my-token",
    role: 'employee'
  )
  User.create!(attributes)
end
