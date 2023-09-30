module vlog

import time

// TODO
// ====
// - add functionality for creating log files and writing to them
// - timestamps from files and terminal output should be the same, don't forget to 'sync'

[flag]
pub enum Severity {
	debug
	normal
	warning
	error
}

fn (s Severity) str() string {
	return match s {
		.debug { 'Debug' }
		.normal { 'Normal' }
		.warning { 'Warning' }
		.error { 'Error' }
		else {
			mut ret := []string{}
			if s.has(.debug) { ret << 'Debug' }
			if s.has(.normal) { ret << 'Normal' }
			if s.has(.warning) { ret << 'Warning' }
			if s.has(.error) { ret << 'Error' }
			ret.join(', ')
		}
	}
}

struct Logger {
mut:
	severity_output Severity
	to_terminal bool
	to_file bool
	log_path string
	log_file string
	disabled bool
}

pub fn Logger.new() Logger {
	return Logger {
		severity_output: .debug | .normal | .warning | .error
		to_terminal: true
	}
}

pub fn (l Logger) log(s Severity, content string) {
	if l.disabled { return }
	if l.severity_output.all(s) {
		if s == .error {
			eprintln(create_time_for_log() + ' | ' + s.str() + ' | ' + content)
		} else {
			println(create_time_for_log() + ' | ' + s.str() + ' | ' + content)
		}
	}
	
}

pub fn (mut l Logger) track_severities(sev Severity) {
	l.severity_output = sev
}

pub fn (mut l Logger) add_severities(sev Severity) {
	l.severity_output.set(sev)
}

pub fn (mut l Logger) disable() {
	l.disabled = true
}

pub fn (mut l Logger) reenable() {
	l.disabled = false
}

pub fn (mut l Logger) set_file_path(path string) {
	// add checks, if path exists
	l.to_file = true
	l.log_path = path
	l.log_file = create_time_for_file_name() + '_log.txt'
	// add check if file creation worked
}

pub fn (mut l Logger) set_terminal_output(output bool) {
	l.to_terminal = output
}

fn create_time_for_file_name() string {
	x := time.now()
	return x.year.str() + '${x.month:02}' + '${x.day:02}-${x.hour:02}' + '${x.minute:02}' + '${x.second:02}_${x.nanosecond:09}'
}

fn create_time_for_log() string {
	return time.now().get_fmt_str(time.FormatDelimiter.no_delimiter, time.FormatTime.hhmmss24_nano, time.FormatDate.yyyymmdd)
}
