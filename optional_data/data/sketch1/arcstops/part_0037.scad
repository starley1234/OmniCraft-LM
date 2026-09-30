$fn = 32;

// ----------------------------------------------------------------------
// Arc stop: segment, 12 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 12;      // extrusion height
profile_points = 17;      // points of the closed outline

profile = [[40.856, 0], [40.341, 5.343], [38.817, 10.489], [31.399, 7.492], [28.738, 12.155], [24.932, 15.943], [20.255, 18.581], [15.045, 19.88], [9.678, 19.746], [4.539, 18.189], [0, 15.321], [6.428, 7.66], [10.437, 9.703], [14.935, 9.781], [19.012, 7.88], [21.844, 4.384], [22.856, 0]];  // single closed polygon, 17 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
