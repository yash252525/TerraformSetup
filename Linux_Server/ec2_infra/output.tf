output "server_details" {
    value = {
        public_ip = aws_instance.my_instance[*].public_ip
        private_ip = aws_instance.my_instance[*].private_ip
        security_groups = aws_instance.my_instance[*].security_groups
        subnet_id = aws_instance.my_instance[*].subnet_id
        # volume_size = aws_instance.my_instance[*].volume_size
        # volume_type = aws_instance.my_instance[*].volume_type
        tags = aws_instance.my_instance[*].tags
    }
}