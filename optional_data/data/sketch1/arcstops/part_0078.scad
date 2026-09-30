$fn = 32;

// ----------------------------------------------------------------------
// Arc stop: segment, 8 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 17;      // points of the closed outline

profile = [[42.893, 0], [42.268, 6.488], [40.417, 12.737], [32.999, 9.74], [30.301, 14.753], [26.577, 19.059], [22.005, 22.452], [16.804, 24.767], [11.223, 25.895], [5.531, 25.782], [0, 24.432], [3.42, 15.035], [9.451, 15.99], [15.4, 14.617], [20.402, 11.115], [23.727, 5.994], [24.893, 0]];  // single closed polygon, 17 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
