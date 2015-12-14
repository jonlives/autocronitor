# autocronitor

[![Gem Version](https://badge.fury.io/rb/autocronitor.png)](http://badge.fury.io/rb/autocronitor)

A CLI tool to parse a standard format crontab file, create monitors in cronitor.io for each job, and automatically add the necessary curl commands to the original crontab.

It assumes that you are using cronitor's "template" feature to configure notifications for your monitors, and that you have created templates which will then be passed to autocronitor.

Please note, cronitor.io (and therefore autocronitor) do not support "informal" cron expressions such as ```@hourly``` or ```@daily```.
## GEM INSTALL
autocronitor is available on rubygems.org - if you have that source in your gemrc, you can simply use:

````
gem install autocronitor
````

Autocronitor Usage
-----------
You can run autocronitor by running the ```autocronitor``` command.

#### Usage
```bash
Usage: autocronitor [-aft]

Specific options:
    -a, --api-key APIKEY             Your cronitor.io API key
    -f, --filename FILENAME          The cron files to read

Email Options: 
    -t, --templace *TEMPLATES        The Cronitor.io templates to send alerts for this monitor to

Text to exclude: 
    -c, --common-text *COMMONTEXT    A space separated list of common text to exclude from cron names
    -i, --common-include-text *COMMONINCLUDETEXT
                                     A space separated list of common text to exclude from cron names (includes strings which contain each phrase)
```

* Mandatory Parameters (you must specify one or the other)
  * -a, --api-key APIKEY             Your cronitor.io API key
  * -f, --filename FILENAME          The crontab files to read
  * -t, --templace *TEMPLATES        The Cronitor.io template(s) to use for notifications

* Optional Parameters
  * -c,  --common-text *COMMONTEXT   A space separated list of common text to exclude from cron names
  * -i, --common-include-text *COMMONINCLUDETEXT    A space separated list of common text to exclude from cron names (includes strings which contain each phrase)


#### Example)

```text
$> autocronitor -a abcdef123456 -f test.conf -t mydefault-template

Processing file test.conf

Cron expression: 10 * * * *
Cron name: testcron
Suggested rules:
[{"rule_type"=>"ran_longer_than", "duration"=>1, "human_readable"=>"Ran for longer than 1 hour", "time_unit"=>"hours", "hours_to_followup_alert"=>24}, {"rule_type"=>"not_completed_in", "duration"=>61, "human_readable"=>"Has not received a complete ping in over 61 minutes", "time_unit"=>"minutes", "hours_to_followup_alert"=>24}]
Creating monitor testcron...
Monitor 'testcron' created with ID abc123

Writing new test.conf with added Cronitor URLs...
```

