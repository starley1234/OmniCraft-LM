$fn = 32;

// ----------------------------------------------------------------------
// C washer: 50 x 30 mm plate with an open slot
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 12;      // points of the closed outline

profile = [[3, 0], [47, 0], [50, 3], [50, 5.47], [32.5, 5.47], [32.5, 24.52], [50, 24.52], [50, 27], [47, 30], [3, 30], [0, 27], [0, 3]];  // single closed polygon, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
