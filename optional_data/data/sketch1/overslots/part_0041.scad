$fn = 32;

// ----------------------------------------------------------------------
// Oversize slot bar: 180 mm bar with 2 oversize windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 4], [1.172, 1.172], [4, 0], [176, 0], [178.828, 1.172], [180, 4], [180, 60], [139, 60], [139, 55], [144, 55], [144, 38], [96, 38], [96, 55], [101, 55], [101, 60], [79, 60], [79, 55], [84, 55], [84, 38], [36, 38], [36, 55], [41, 55], [41, 60], [0, 60]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
