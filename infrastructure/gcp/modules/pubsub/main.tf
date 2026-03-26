locals {
  topics = [
    "traffic-telemetry",
    "traffic-events",
    "apc-events",
    "hr-events"
  ]

  # Map topics to their default subscriptions
  subscriptions = {
    "traffic-telemetry" = ["traffic-control-center-sub"]
    "traffic-events"    = ["finance-billing-sub"]
    "apc-events"        = ["finance-apc-sub"]
    "hr-events"         = ["hr-guardrails-sub"]
  }
}

resource "google_pubsub_topic" "topics" {
  for_each = toset(local.topics)
  name     = each.key
  project  = var.project_id
}

# Flatten the map to a list of objects for easier iteration
locals {
  sub_list = flatten([
    for topic, subs in local.subscriptions : [
      for sub in subs : {
        topic = topic
        sub   = sub
      }
    ]
  ])
}

resource "google_pubsub_subscription" "subscriptions" {
  count   = length(local.sub_list)
  name    = local.sub_list[count.index].sub
  topic   = google_pubsub_topic.topics[local.sub_list[count.index].topic].id
  project = var.project_id

  # 7 days retention is a good default
  message_retention_duration = "604800s" 
  retain_acked_messages      = true
  
  ack_deadline_seconds = 20
}