// Query to fetch diary entries
const String fetchDiariesQuery = """
query Query(\$userId: ID!) {
  diaryEntries(userId: \$userId) {
    id
    title
    content
    date
  }
}
""";

// Mutation to create a diary entry
const String createDiaryMutation = """
mutation CreateDiary(\$userId: ID!, \$input: CreateDiaryInput!) {
  createDiary(userId: \$userId, input: \$input) {
    id
    title
    content
  }
}
""";

// Mutation to delete a diary entry
const String deleteDiaryMutation = """
mutation Mutation(\$diaryId: ID!) {
  deleteDiary(id: \$diaryId)
}
""";
