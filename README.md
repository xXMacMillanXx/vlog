# vlog

vlog is a module for the V language. It provides simple to use logging capabilities.
You can specify a severity for your log entries and decide which of those should be logged.
Currently the module only outputs log entries in the terminal but soon (TM) logging to files will be possible.

# Usage

```v
module main

import vlog

mut logger := vlog.Logger.new()

x := 5
logger.log(vlog.Severity.debug, 'Value of x: ${x}')
```

Severity provides debug, normal, warning and error, so you can specify if an entry is a debug message, information, a warning (e.g., a reconnect to a server) or an error (e.g., information why the program stopped).
You can specify with the 'logger' which severities should be logger, so if you need less logs / information you could only log entries with severity warning and error.

```v
module main

import vlog

mut logger := vlog.Logger.new()
logger.track_severities(vlog.Severity.warning | vlog.Severity.error)

x := 5
logger.log(vlog.Severity.debug, 'Value of x: ${x}') // not logged
logger.log(vlog.Severity.warning, 'This will be logged')
```
