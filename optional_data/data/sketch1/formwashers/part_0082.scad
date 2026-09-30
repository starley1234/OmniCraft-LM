$fn = 32;

// ----------------------------------------------------------------------
// C washer: 50 x 30 mm plate with an open slot
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 12;      // points of the closed outline

profile = [[3, 0], [47, 0], [50, 3], [50, 8.65], [37.5, 8.65], [37.5, 21.35], [50, 21.35], [50, 27], [47, 30], [3, 30], [0, 27], [0, 3]];  // single closed polygon, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
