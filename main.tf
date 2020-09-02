locals {
  type = "SavedSearchWithScheduleSyncDefinition"

  search = {
    queryText = var.search["query_text"]
    defaultTimeRange = var.search["default_time_range"]
    byReceiptTime = var.search["by_receipt_time"]
    viewName = ""
    viewStartTime = "1970-01-01T00:00:00Z"
    queryParameters = [],
    parsingMode = "Manual"
  }

  searchSchedule = {
    cronExpression = var.search_cron_schedule
    displayableTimeRange = "-15m"
    parseableTimeRange = {
      type = "BeginBoundedTimeRange"
      from = {
        type = "RelativeTimeRangeBoundary"
        relativeTime = "-15m"
      }
      to = null
    }
    timeZone = "Australia/Melbourne"
    threshold = {
      thresholdType = var.threshold["threshold_type"]
      operator = var.threshold["operator"]
      count = var.threshold["count"]
    }
    notification = {
      taskType = "WebhookSearchNotificationSyncDefinition"
      webhookId = "000000000001049D"
      payload = var.notification["payload"]
      itemizeAlerts = var.notification["itemize_alerts"]
      maxItemizedAlerts = var.notification["max_itemized_alerts"]
    }
    scheduleType = var.schedule_type
    muteErrorEmails = var.mute_error_emails
    parameters = []
  }
}


