$fn = 32;

// ----------------------------------------------------------------------
// Key bar: parallel key, 6 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 11;      // points of the closed outline

profile = [[0, 2.984], [0.573, 1.22], [2.073, 0.13], [66.686, 0], [68.5, 0.385], [69.741, 1.763], [69.934, 3.607], [69.007, 5.213], [67.314, 5.967], [2.073, 5.837], [0.573, 4.747]];  // single closed polygon, 11 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
