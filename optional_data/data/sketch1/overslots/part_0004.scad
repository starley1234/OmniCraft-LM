$fn = 32;

// ----------------------------------------------------------------------
// Oversize slot bar: 210 mm bar with 3 oversize windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 32;      // points of the closed outline

profile = [[0, 4], [1.172, 1.172], [4, 0], [206, 0], [208.828, 1.172], [210, 4], [210, 60], [175.5, 60], [175.5, 57], [178.5, 57], [178.5, 30], [136.5, 30], [136.5, 57], [139.5, 57], [139.5, 60], [123, 60], [123, 57], [126, 57], [126, 30], [84, 30], [84, 57], [87, 57], [87, 60], [70.5, 60], [70.5, 57], [73.5, 57], [73.5, 30], [31.5, 30], [31.5, 57], [34.5, 57], [34.5, 60], [0, 60]];  // single closed polygon, 32 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
