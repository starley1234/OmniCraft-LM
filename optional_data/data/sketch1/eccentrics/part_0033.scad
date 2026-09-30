$fn = 32;

// ----------------------------------------------------------------------
// Eccentric disc: step, 8 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 12;      // points of the closed outline

profile = [[0, 26], [3.483, 13], [13, 3.483], [26, 0], [39, 3.483], [48.517, 13], [52, 26], [48.517, 39], [39, 48.517], [26, 52], [13, 48.517], [3.483, 39]];  // single closed polygon, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
