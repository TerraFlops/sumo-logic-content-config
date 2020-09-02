variable "name" {
  type = string
  description = "Name of the Search to create in Sumologic"
}

variable "description" {
  type = string
  description = "Description of the search and content"
}

variable "search_cron_schedule" {
  type = string
  description = "The cron expression for how often this search should run"
}

variable "schedule_type" {
  type = string
  description = "The frequency to run the search, use 'Custom' to use the cron expression"
  default = "RealTime"
}

variable "mute_error_emails" {
  type = bool
  description = "Enable emails on failures to search"
  default = true
}

variable "search" {
  type = object({
    query_text = string
    default_time_range = string
    by_receipt_time = bool
  })
  description = "Object of the query, default time range, and to boolean to enable the receipt time"
}

variable "threshold" {
  type = object({
    threshold_type = string
    operator = string
    count = number
  })
  description = "Object of the threshold type, operator, and count to define the threshold for sending notifications"
}

variable "notification" {
  type = object({
    webhook_id = string
    payload = string
    itemize_alerts = bool
    max_itemized_alerts = number
  })
  description = "Object of payload, boolean to itemize alerts, and number of maximum itemized alerts for notifications"
}

