$fn = 32;

// ----------------------------------------------------------------------
// C washer: 60 x 30 mm plate with an open slot
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 12;      // points of the closed outline

profile = [[3, 0], [57, 0], [60, 3], [60, 5.47], [33, 5.47], [33, 24.52], [60, 24.52], [60, 27], [57, 30], [3, 30], [0, 27], [0, 3]];  // single closed polygon, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
