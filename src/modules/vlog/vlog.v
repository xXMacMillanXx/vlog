module vlog

import time
import os

// TODO
// ====
// - add to Logger.new() a name parameter, which gets added to the log entry and log file name

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

struct LoggingError {
	Error
	message string
}

fn (err LoggingError) msg() string {
	return 'Logging Error: ${err.message}'
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
		log_msg := create_time_for_log() + ' | ' + s.str() + ' | ' + content
		if l.to_terminal {
			if s == .error {
				eprintln(log_msg)
			} else {
				println(log_msg)
			}
		}
		if l.to_file {
			l.append_to_log(log_msg) or {
				eprintln(create_time_for_log() + ' | Error | Error occurred during writing to log file.')
			}
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

pub fn (mut l Logger) set_file_path(path string) ! {
	if l.disabled { return }
	if !os.exists(path) {
		return LoggingError { message: 'The path for the file location does not exist, or might be not accessible: ${path}' }
	}
	l.log_path = path_parse(path)
	l.log_file = create_time_for_file_name() + '_log.txt'

	mut f := os.create(l.log_path + l.log_file) or {
		return LoggingError { message: 'The file couldn\'t be created: ${l.log_path + l.log_file}' }
	}
	f.close()
	l.to_file = true
}

pub fn (mut l Logger) set_terminal_output(output bool) {
	l.to_terminal = output
}

fn (l Logger) append_to_log(msg string) ! {
	mut f := os.open_append(l.log_path + l.log_file)!
	f.writeln(msg)!
	f.close()
}

fn path_parse(path string) string {
	path_sep := $if windows { '\\' } $else { '/' }

	return match path[path.len-1] {
		`/`, `\\` { path }
		else { path + path_sep }
	}
}

fn create_time_for_file_name() string {
	x := time.now()
	return x.year.str() + '${x.month:02}' + '${x.day:02}-${x.hour:02}' + '${x.minute:02}' + '${x.second:02}_${x.nanosecond:09}'
}

fn create_time_for_log() string {
	return time.now().get_fmt_str(time.FormatDelimiter.hyphen, time.FormatTime.hhmmss24_nano, time.FormatDate.yyyymmdd)
}
