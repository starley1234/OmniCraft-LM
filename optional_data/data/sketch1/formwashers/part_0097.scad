$fn = 32;

// ----------------------------------------------------------------------
// C washer: 40 x 30 mm plate with an open slot
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 12;      // points of the closed outline

profile = [[3, 0], [37, 0], [40, 3], [40, 5], [26, 5], [26, 25], [40, 25], [40, 27], [37, 30], [3, 30], [0, 27], [0, 3]];  // single closed polygon, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
