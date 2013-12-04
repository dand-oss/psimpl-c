/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. */

/*
 psimpl-c
 Copyright (c) 2013 Jamie Bullock <jamie@jamiebullock.com>
 
 Based on psimpl
 Copyright (c) 2010-2011 Elmar de Koning <edekoning@gmail.com>
 */

#include "psimpl-c.h"
#include "psimpl/psimpl.h"

#include <stdio.h>

double *psimpl_simplify_douglas_peucker(
                                        psimpl_LineDimension dimensions,
                                        uint64_t points,
                                        double tolerance,
                                        double *original_points,
                                        double *simplified_points
                                        )
{
    double *original_end = original_points + (points * dimensions);
    
    switch (dimensions)
    {
        case psimpl_LineDimension_1D:
            return psimpl::simplify_douglas_peucker <1> (original_points, original_end, tolerance, simplified_points);
            
        case psimpl_LineDimension_2D:
            return psimpl::simplify_douglas_peucker <2> (original_points, original_end, tolerance, simplified_points);
            
        case psimpl_LineDimension_3D:
            return psimpl::simplify_douglas_peucker <3> (original_points, original_end, tolerance, simplified_points);
            
        default:
            fprintf(stderr, "Error: invalid dimensions: %d\n", dimensions);
            return  NULL;
            break;
    }
}


