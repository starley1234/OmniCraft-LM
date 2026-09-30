$fn = 32;

// ----------------------------------------------------------------------
// Heat sink frame: 80 x 52 mm frame, 10 mm walls
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 12;      // points of the closed outline

profile = [[0, 4], [1.172, 1.172], [4, 0], [76, 0], [78.828, 1.172], [80, 4], [80, 52], [70, 52], [70, 10], [10, 10], [10, 52], [0, 52]];  // single closed polygon, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
