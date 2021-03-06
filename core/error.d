/*
 * error.d
 *
 * This module implements the Error objects useable by the system.
 * This objects are for irrecoverable failures.
 *
 * Originated: May 8th, 2010
 *
 */

module core.error;

import core.definitions;

// Description: This is for non irrecoverable failure.
class Error : Exception {
	this(string msg, string file = "", ulong line = 0) {
		super(msg, file, line);
	}

private:
//	Error _next;
}

abstract class RuntimeError : Error {
	this(string msg, string file, ulong line){
		super(msg,file,line);
	}

static:

	// Description: This Error is thrown when assertions fail.
	class Assert : RuntimeError {
		this(string msg, string file, ulong line) {
			super("Assertion `" ~ msg ~ "` failed", file, line);
		}

		this(string file, ulong line) {
			super("Assertion failed",file,line);
		}
	}

	// Description: This Error is thrown when a switch statement does not have a default and there is no case available.
	class NoDefaultCase : RuntimeError {
		this(string file, ulong line) {
			super("Switch has no default",file,line);
		}
	}
}
