$fn = 32;

// ----------------------------------------------------------------------
// Oversize slot bar: 150 mm bar with 2 oversize windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 4], [1.172, 1.172], [4, 0], [146, 0], [148.828, 1.172], [150, 4], [150, 50], [112.5, 50], [112.5, 45], [117.5, 45], [117.5, 20], [82.5, 20], [82.5, 45], [87.5, 45], [87.5, 50], [62.5, 50], [62.5, 45], [67.5, 45], [67.5, 20], [32.5, 20], [32.5, 45], [37.5, 45], [37.5, 50], [0, 50]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
