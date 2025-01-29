// Mutation to register (create) a user
const String registerUserMutation = """
mutation Mutation(\$input: CreateUserInput!) {
  createUser(input: \$input) {
    _id
  }
}
""";

// Mutation to register (create) a user
const String loginUserMutation = """
mutation Mutation(\$input: LoginInput!) {
  login(input: \$input) {
    token
  }
}
""";

// Query to fetch logged-in user's profile
const String meQuery = """
    query Me {
      me {
        id
        name
        email
      }
    }
  """;
