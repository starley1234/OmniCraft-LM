$fn = 32;

// ----------------------------------------------------------------------
// Heat sink frame: 80 x 60 mm frame, 6 mm walls
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 18;      // extrusion height
profile_points = 12;      // points of the closed outline

profile = [[0, 4], [1.172, 1.172], [4, 0], [76, 0], [78.828, 1.172], [80, 4], [80, 60], [74, 60], [74, 10], [6, 10], [6, 60], [0, 60]];  // single closed polygon, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
