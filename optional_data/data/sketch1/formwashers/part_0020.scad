$fn = 32;

// ----------------------------------------------------------------------
// C washer: 75 x 22 mm plate with an open slot
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 12;      // points of the closed outline

profile = [[3, 0], [72, 0], [75, 3], [75, 5], [41.25, 5], [41.25, 17], [75, 17], [75, 19], [72, 22], [3, 22], [0, 19], [0, 3]];  // single closed polygon, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
