$fn = 32;

// ----------------------------------------------------------------------
// Oversize slot bar: 150 mm bar with 3 oversize windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 32;      // points of the closed outline

profile = [[0, 4], [1.172, 1.172], [4, 0], [146, 0], [148.828, 1.172], [150, 4], [150, 50], [122.5, 50], [122.5, 47], [127.5, 47], [127.5, 20], [97.5, 20], [97.5, 47], [102.5, 47], [102.5, 50], [85, 50], [85, 47], [90, 47], [90, 20], [60, 20], [60, 47], [65, 47], [65, 50], [47.5, 50], [47.5, 47], [52.5, 47], [52.5, 20], [22.5, 20], [22.5, 47], [27.5, 47], [27.5, 50], [0, 50]];  // single closed polygon, 32 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
