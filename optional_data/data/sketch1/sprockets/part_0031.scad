$fn = 32;

// ----------------------------------------------------------------------
// Chain sprocket: 10 teeth, 30 mm root radius
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 20;      // points of the closed outline

profile = [[65.128, 30.27], [71.183, 40.929], [62.574, 48.634], [61.207, 60.816], [49.713, 61.989], [41.446, 71.041], [31.458, 65.235], [19.45, 67.699], [14.782, 57.13], [3.619, 52.066], [6.055, 40.771], [0, 30.113], [8.609, 22.407], [9.976, 10.225], [21.47, 9.052], [29.737, 0], [39.725, 5.807], [51.733, 3.342], [56.401, 13.911], [67.564, 18.976]];  // single closed polygon, 20 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
