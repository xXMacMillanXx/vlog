# vlog

IMPORTANT!  
This module is currently depricated, since I found out that V has its own log module.  
I still might continue working on this module for practice, but probably not to release it as a finished module.  
If you are looking for a V log module, just use `import log`.

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
logger.track_severities(.warning | .error)

x := 5
logger.log(.debug, 'Value of x: ${x}') // not logged
logger.log(.warning, 'This will be logged')
```

To write to a log file you can use the following.

```v
module main

import vlog

mut logger := vlog.Logger.new()
logger.set_file_path('./logs/')!
logger.set_terminal_output(false)

logger.log(.normal, 'Gets logged to a file, but not to the terminal output.')
```
