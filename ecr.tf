resource "aws_ecr_repository" "example" {
  name = "example"
  tags = merge(
    local.common_tags,
    { DockerHub : "dwpdigital/example" }
  )
}

resource "aws_ecr_repository_policy" "example" {
  repository = aws_ecr_repository.example.name
  policy     = data.terraform_remote_state.management.outputs.ecr_iam_policy_document
}

output "ecr_example_url" {
  value = aws_ecr_repository.example.repository_url
}
