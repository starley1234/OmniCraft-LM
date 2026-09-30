$fn = 32;

// ----------------------------------------------------------------------
// Heat sink frame: 60 x 40 mm frame, 6 mm walls
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 12;      // points of the closed outline

profile = [[0, 4], [1.172, 1.172], [4, 0], [56, 0], [58.828, 1.172], [60, 4], [60, 40], [54, 40], [54, 10], [6, 10], [6, 40], [0, 40]];  // single closed polygon, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
