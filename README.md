
### About Shoreline
The Shoreline platform provides real-time monitoring, alerting, and incident automation for cloud operations. Use Shoreline to detect, debug, and automate repairs across your entire fleet in seconds with just a few lines of code.

Shoreline Agents are efficient and non-intrusive processes running in the background of all your monitored hosts. Agents act as the secure link between Shoreline and your environment's Resources, providing real-time monitoring and metric collection across your fleet. Agents can execute actions on your behalf -- everything from simple Linux commands to full remediation playbooks -- running simultaneously across all the targeted Resources.

Since Agents are distributed throughout your fleet and monitor your Resources in real time, when an issue occurs Shoreline automatically alerts your team before your operators notice something is wrong. Plus, when you're ready for it, Shoreline can automatically resolve these issues using Alarms, Actions, Bots, and other Shoreline tools that you configure. These objects work in tandem to monitor your fleet and dispatch the appropriate response if something goes wrong -- you can even receive notifications via the fully-customizable Slack integration.

Shoreline Notebooks let you convert your static runbooks into interactive, annotated, sharable web-based documents. Through a combination of Markdown-based notes and Shoreline's expressive Op language, you have one-click access to real-time, per-second debug data and powerful, fleetwide repair commands.

### What are Shoreline Op Packs?
Shoreline Op Packs are open-source collections of Terraform configurations and supporting scripts that use the Shoreline Terraform Provider and the Shoreline Platform to create turnkey incident automations for common operational issues. Each Op Pack comes with smart defaults and works out of the box with minimal setup, while also providing you and your team with the flexibility to customize, automate, codify, and commit your own Op Pack configurations.

# Azure Web App Traffic Routing Issues

Azure Web App Traffic Routing Issues refer to problems that can arise in the routing of traffic to and from web applications hosted on the Azure WebApp. These issues can result from a variety of causes, including misconfigurations, DNS problems, or changes in traffic routing. When traffic routing issues occur, they can impact the availability and performance of web applications, potentially leading to downtime or other disruptions. Timely identification and resolution of these issues is critical to ensure that web applications remain accessible and responsive to users.

### Parameters

```shell
export RESOURCE_GROUP_NAME="PLACEHOLDER"
export WEB_APP_NAME="PLACEHOLDER"
export DNS_ZONE_NAME="PLACEHOLDER"
export SLOT_NAME="PLACEHOLDER"
export TRAFFIC_PERCENT="PLACEHOLDER"
```

## Debug

### Check the status of the Azure Web App

```shell
az webapp show -g ${RESOURCE_GROUP_NAME} -n ${WEB_APP_NAME}
```

### Check the WebApp's SSL bindings

```shell
az webapp config ssl list --resource-group ${RESOURCE_GROUP_NAME}
```

### Check if the web app is using a custom domain name

```shell
az webapp config hostname list --resource-group ${RESOURCE_GROUP_NAME} --webapp-name ${WEB_APP_NAME}
```

### Check the status of the Azure DNS service

```shell
az network dns zone show -g ${RESOURCE_GROUP_NAME} -n ${DNS_ZONE_NAME}
```

### Check the traffic routing settings for the web app

```shell
az webapp traffic-routing show -g ${RESOURCE_GROUP_NAME} -n ${WEB_APP_NAME}
```

## Repair

### Check and Implement routing rules for deployment slots for web app.

```shell
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
```