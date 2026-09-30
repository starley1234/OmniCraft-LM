$fn = 32;

// ----------------------------------------------------------------------
// C washer: 50 x 22 mm plate with an open slot
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 12;      // points of the closed outline

profile = [[3, 0], [47, 0], [50, 3], [50, 5], [37.5, 5], [37.5, 17], [50, 17], [50, 19], [47, 22], [3, 22], [0, 19], [0, 3]];  // single closed polygon, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
