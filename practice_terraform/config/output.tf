output "server_details" {
  value = {
      arn = aws_instance.yash-test-ec2.arn
      region = aws_instance.yash-test-ec2.region
      az = aws_instance.yash-test-ec2.availability_zone
      instance_state = aws_instance.yash-test-ec2.instance_state
      instance_type = aws_instance.yash-test-ec2.instance_type
      host_id = aws_instance.yash-test-ec2.host_id
      private_dns = aws_instance.yash-test-ec2.private_dns
      private_ip = aws_instance.yash-test-ec2.private_ip
      public_dns = aws_instance.yash-test-ec2.public_dns
      public_ip = aws_instance.yash-test-ec2.public_ip
      ebs_block_device = aws_instance.yash-test-ec2.ebs_block_device  
  }
}