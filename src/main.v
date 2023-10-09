module main

import vlog

fn main() {
	mut logger := vlog.Logger.new()

	// logger.track_severities(.normal | .debug)
	// logger.disable()
	
	logger.set_file_path('./logs/')!
	logger.set_terminal_output(false)

	//logger.log(vlog.Severity.debug, 'Value of x is 5.')
	//logger.log(vlog.Severity.normal, 'Things are happening.')
	// logger.reenable()
	//logger.log(vlog.Severity.warning, 'Couldn\'t connect to server. Retry.')
	//logger.log(vlog.Severity.error, 'Creating file x was not possible!')

	logger.log(.normal, "Before Loop")
	for i in 0..100 {
		println("Printing ... ${i}")
		logger.log(.debug, "Logging ${i}")
	}
	logger.log(.normal, "After Loop")
}
