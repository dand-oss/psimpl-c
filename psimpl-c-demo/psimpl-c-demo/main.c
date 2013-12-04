//
//  main.c
//  psimpl-c-demo
//
//  Created by Jamie Bullock on 04/12/2013.
//  Copyright (c) 2013 Jamie Bullock. All rights reserved.
//

#include "psimpl-c.h"

#include <stdlib.h>
#include <stdio.h>


int main(int argc, const char * argv[])
{
    
    double tolerance = 10;
    psimpl_LineDimension dimensions = psimpl_LineDimension_1D;
    uint64_t points = 10;
    
    double polyline[10] = {0, 1, 2, 3, 40, 5, 6, 7, 8, 9};
    
    double *result = (double *)malloc(dimensions * points * sizeof(double));
    
    double *end = psimpl_simplify_douglas_peucker(dimensions, points, tolerance, polyline, result);
    
    double *pointer = &result[0];
    
    while (pointer != end)
    {
        fprintf(stdout, "%f\n", *pointer++);
    }
    
    free(result);
    
    return 0;
}
