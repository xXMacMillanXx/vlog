# vlog

vlog is a module for the V language. It provides simple to use logging capabilities.
You can specify a severity for your log entries and decide which of those should be logged.
Log entries can be output on the terminal, a log file or both. Currently, everytime the program runs, a new log file gets created, there is no functionality to reuse the same log file, yet.

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

To write to a log file you can use the following.

```v
module main

import vlog

mut logger := vlog.Logger.new()
logger.set_file_path('./logs/')
logger.set_terminal_output(false)

logger.log(vlog.Severity.normal, 'Gets logged to a file, but not to the terminal output.')
```
