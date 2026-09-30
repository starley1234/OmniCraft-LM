$fn = 32;

// ----------------------------------------------------------------------
// Oversize slot bar: 180 mm bar with 3 oversize windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 32;      // points of the closed outline

profile = [[0, 4], [1.172, 1.172], [4, 0], [176, 0], [178.828, 1.172], [180, 4], [180, 40], [143.5, 40], [143.5, 35], [148.5, 35], [148.5, 14], [121.5, 14], [121.5, 35], [126.5, 35], [126.5, 40], [98.5, 40], [98.5, 35], [103.5, 35], [103.5, 14], [76.5, 14], [76.5, 35], [81.5, 35], [81.5, 40], [53.5, 40], [53.5, 35], [58.5, 35], [58.5, 14], [31.5, 14], [31.5, 35], [36.5, 35], [36.5, 40], [0, 40]];  // single closed polygon, 32 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
