$fn = 32;

// ----------------------------------------------------------------------
// Oversize slot bar: 210 mm bar with 2 oversize windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 4], [1.172, 1.172], [4, 0], [206, 0], [208.828, 1.172], [210, 4], [210, 60], [161.5, 60], [161.5, 55], [164.5, 55], [164.5, 30], [115.5, 30], [115.5, 55], [118.5, 55], [118.5, 60], [91.5, 60], [91.5, 55], [94.5, 55], [94.5, 30], [45.5, 30], [45.5, 55], [48.5, 55], [48.5, 60], [0, 60]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
