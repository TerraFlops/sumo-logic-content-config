# Terraflops Terraform Module
 
### Module name

Generates the config required for use with the [sumo-logic-content](https://github.com/TerraFlops/sumo-logic-content) module

#### Example usage

```hcl-terraform
module "content_config" {
  source = "git::https://github.com/TerraFlops/sumo-logic-content-config?ref=v1.0"

  name = "Test Search"
  description = "Testing deploying content from terraform"

  search_cron_schedule = "17 1 * * * ? *"
  schedule_type = "Custom"
  search = {
    query_text = <<EOF
      _sourceCategory = pg/prod/cloudtrail "ConsoleLogin"
      | json "eventTime" as et
      | formatDate(parseDate(et, "yyyy-MM-dd'T'HH:mm:ss", "UTC"), "yyyy-MM-dd HH:mm:ss", "Australia/Melbourne") as eventTime
      | parse "\"eventName\":\"*\"" as eventName nodrop
      | where eventName="ConsoleLogin"
      | parse "\"sourceIPAddress\":\"*\"" as sourceIPAddress nodrop
      | parse "\"userName\":\"*\"" as user_name nodrop
      | json field=_raw "userIdentity.principalId" as principal_id nodrop
      | json field=_raw "userIdentity.type" as login_type nodrop
      | json field=_raw "userIdentity.arn" as login_arn nodrop
      | parse regex field = principal_id ":(?<user_principal>.+)" nodrop
      | if (user_name="", user_principal, user_name) as user
      | json field=_raw "responseElements.ConsoleLogin" as loginResult nodrop
    EOF
    default_time_range = "-45m"
    by_receipt_time = true
  }

  notification = {
    payload = <<EOF
    {
      "text": "Sumo Logic Alert: *{{SearchName}}*",
      "attachments": [
        {
          "fields": [],
          "mrkdwn_in": [
            "text",
            "pretext"
          ],
          "color": "#29A1E6"
        }
      ]
    }
    EOF
    itemize_alerts = true
    max_itemized_alerts = 50
  }

  threshold = {
    threshold_type = "group"
    operator = "gt"
    count = 0
  }
}
```
