$fn = 32;

// ----------------------------------------------------------------------
// Oversize slot bar: 210 mm bar with 3 oversize windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 32;      // points of the closed outline

profile = [[0, 4], [1.172, 1.172], [4, 0], [206, 0], [208.828, 1.172], [210, 4], [210, 50], [173.5, 50], [173.5, 47], [178.5, 47], [178.5, 24], [136.5, 24], [136.5, 47], [141.5, 47], [141.5, 50], [121, 50], [121, 47], [126, 47], [126, 24], [84, 24], [84, 47], [89, 47], [89, 50], [68.5, 50], [68.5, 47], [73.5, 47], [73.5, 24], [31.5, 24], [31.5, 47], [36.5, 47], [36.5, 50], [0, 50]];  // single closed polygon, 32 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
