resource "shoreline_notebook" "azure_web_app_traffic_routing_issues" {
  name       = "azure_web_app_traffic_routing_issues"
  data       = file("${path.module}/data/azure_web_app_traffic_routing_issues.json")
  depends_on = [shoreline_action.invoke_set_traffic_routing]
}

resource "shoreline_file" "set_traffic_routing" {
  name             = "set_traffic_routing"
  input_file       = "${path.module}/data/set_traffic_routing.sh"
  md5              = filemd5("${path.module}/data/set_traffic_routing.sh")
  description      = "Check and Implement routing rules for deployment slots for web app."
  destination_path = "/tmp/set_traffic_routing.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_set_traffic_routing" {
  name        = "invoke_set_traffic_routing"
  description = "Check and Implement routing rules for deployment slots for web app."
  command     = "`chmod +x /tmp/set_traffic_routing.sh && /tmp/set_traffic_routing.sh`"
  params      = ["TRAFFIC_PERCENT","WEB_APP_NAME","RESOURCE_GROUP_NAME","SLOT_NAME"]
  file_deps   = ["set_traffic_routing"]
  enabled     = true
  depends_on  = [shoreline_file.set_traffic_routing]
}

