module main

import vlog

fn main() {
	mut logger := vlog.Logger.new()

	// logger.track_severities(vlog.Severity.normal | vlog.Severity.debug)
	// logger.disable()
	
	// logger.set_file_path('./')!
	// logger.set_terminal_output(false)

	logger.log(vlog.Severity.debug, 'Value of x is 5.')
	logger.log(vlog.Severity.normal, 'Things are happening.')
	// logger.reenable()
	logger.log(vlog.Severity.warning, 'Couldn\'t connect to server. Retry.')
	logger.log(vlog.Severity.error, 'Creating file x was not possible!')
}
