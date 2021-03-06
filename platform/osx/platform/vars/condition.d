/*
 * condition.d
 *
 * This struct contains implementation variables necessary for
 * using condition variables in Unix (pthread)
 *
 * Author: Dave Wilkinson
 * Originated: December 5th, 2009
 *
 */

module platform.vars.condition;

import platform.unix.common;

struct ConditionPlatformVars {
	pthread_cond_t cond_id;
}
