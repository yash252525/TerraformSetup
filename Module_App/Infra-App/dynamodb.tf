resource "aws_dynamodb_table" "basic-dynamodb-table" {
  name           = "${var.env}-infra-app-Remote_Operator_Table"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = var.hash_key


  attribute {
    name = var.hash_key
    type = "S"
  }


  tags = {
    Name        = "${var.env}-infra-app-Remote_Operator_Table"
    Environment = var.env
  }
}