/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. */

/*
    psimpl-c
    Copyright (c) 2013 Jamie Bullock <jamie@jamiebullock.com>
 
    Based on psimpl
    Copyright (c) 2010-2011 Elmar de Koning <edekoning@gmail.com>
*/

#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

double *psimpl_simplify_douglas_peucker(
                                        uint8_t dimensions,
                                        double tolerance,
                                        double *original_points,
                                        double *simplified_points
                                        );

#ifdef __cplusplus
}
#endif