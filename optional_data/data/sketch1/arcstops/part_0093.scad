$fn = 32;

// ----------------------------------------------------------------------
// Arc stop: segment, 8 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 17;      // points of the closed outline

profile = [[40.856, 0], [40.341, 5.343], [38.817, 10.489], [31.399, 7.492], [28.738, 12.155], [24.932, 15.943], [20.255, 18.581], [15.045, 19.88], [9.678, 19.746], [4.539, 18.189], [0, 15.321], [5.142, 9.193], [9.953, 11.644], [15.351, 11.738], [20.244, 9.456], [23.641, 5.26], [24.856, 0]];  // single closed polygon, 17 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
