// Query to fetch diary entries
const String fetchDiariesQuery = """
  query DiaryEntries {
    diaryEntries {
      id
      title
      content
      date
    }
  }
""";

// Mutation to create a diary entry
const String createDiaryMutation = """
    mutation CreateDiary(\$input: CreateDiaryInput!) {
      createDiary(input: \$input) {
        title
        content
      }
    }
  """;

// Mutation to delete a diary entry
const String deleteDiaryMutation = """
    mutation DeleteDiary(\$deleteDiaryId: ID!) {
      deleteDiary(id: \$deleteDiaryId)
    }
  """;
