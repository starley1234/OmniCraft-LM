$fn = 32;

// ----------------------------------------------------------------------
// C washer: 40 x 22 mm plate with an open slot
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 12;      // points of the closed outline

profile = [[3, 0], [37, 0], [40, 3], [40, 7.83], [30, 7.83], [30, 14.18], [40, 14.18], [40, 19], [37, 22], [3, 22], [0, 19], [0, 3]];  // single closed polygon, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
