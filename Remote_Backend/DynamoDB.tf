resource "aws_dynamodb_table" "basic-dynamodb-table-ap-south" {
  name           = "Remote_Operator_Table_AP_South"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "LockID"


  attribute {
    name = "LockID"
    type = "S"
  }


  tags = {
    Name        = "Remote_Operator_Table"
  }
}