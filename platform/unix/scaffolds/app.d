module platform.unix.scaffolds.app;

import platform.unix.vars;
import platform.unix.common;

import core.view;
import core.graphics;

import bases.window;
import core.window;
import platform.unix.main;
import core.string;
import core.file;

import core.main;

import core.definitions;

import console.main;

void AppStart()
{
}

void AppEnd()
{
	// this code is executed at uninitialization of the application
	_pfvars.running = false;
}