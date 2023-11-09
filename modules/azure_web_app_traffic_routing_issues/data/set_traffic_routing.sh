# Define variables
resource_group=${RESOURCE_GROUP_NAME}
web_app_name=${WEB_APP_NAME}
slot_name=${SLOT_NAME}
traffic_percent_to_route=${TRAFFIC_PERCENT}

# Get the current distribution of traffic across the slots
az webapp traffic-routing show --resource-group $resource_group --name $web_app_name

# Clear the routing rules and send all the traffic to production
az webapp traffic-routing clear --resource-group $resource_group --name $web_app_name

# Configure routing traffic to deployment slots
az webapp traffic-routing set --distribution $slot_name=$traffic_percent_to_route --resource-group $resource_group --name $web_app_name