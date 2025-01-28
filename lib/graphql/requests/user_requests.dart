// Mutation to register (create) a user
const String registerUserMutation = """
mutation Mutation(\$input: CreateUserInput!) {
  createUser(input: \$input) {
    _id
  }
}
""";

// Mutation to register (create) a user
const String loginMutation = """
mutation Mutation(\$input: LoginInput!) {
  login(input: \$input) {
    token
  }
}
""";
