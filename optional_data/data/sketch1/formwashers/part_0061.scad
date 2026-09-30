$fn = 32;

// ----------------------------------------------------------------------
// C washer: 60 x 22 mm plate with an open slot
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 12;      // points of the closed outline

profile = [[3, 0], [57, 0], [60, 3], [60, 7.83], [45, 7.83], [45, 14.18], [60, 14.18], [60, 19], [57, 22], [3, 22], [0, 19], [0, 3]];  // single closed polygon, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
