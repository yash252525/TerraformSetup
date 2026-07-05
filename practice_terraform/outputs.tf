output "final_server_details" {
  description = "Pulls the server details from the child module in the config folder"

  # This grabs the "server_details" output from your "test" module
  value = module.test.server_details
}