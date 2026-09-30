$fn = 32;

// ----------------------------------------------------------------------
// Oversize slot bar: 120 mm bar with 3 oversize windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 32;      // points of the closed outline

profile = [[0, 4], [1.172, 1.172], [4, 0], [116, 0], [118.828, 1.172], [120, 4], [120, 50], [97.5, 50], [97.5, 47], [100.5, 47], [100.5, 28], [79.5, 28], [79.5, 47], [82.5, 47], [82.5, 50], [67.5, 50], [67.5, 47], [70.5, 47], [70.5, 28], [49.5, 28], [49.5, 47], [52.5, 47], [52.5, 50], [37.5, 50], [37.5, 47], [40.5, 47], [40.5, 28], [19.5, 28], [19.5, 47], [22.5, 47], [22.5, 50], [0, 50]];  // single closed polygon, 32 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
