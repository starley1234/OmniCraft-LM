$fn = 32;

// ----------------------------------------------------------------------
// Oversize slot bar: 180 mm bar with 3 oversize windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 32;      // points of the closed outline

profile = [[0, 4], [1.172, 1.172], [4, 0], [176, 0], [178.828, 1.172], [180, 4], [180, 60], [150, 60], [150, 55], [153, 55], [153, 38], [117, 38], [117, 55], [120, 55], [120, 60], [105, 60], [105, 55], [108, 55], [108, 38], [72, 38], [72, 55], [75, 55], [75, 60], [60, 60], [60, 55], [63, 55], [63, 38], [27, 38], [27, 55], [30, 55], [30, 60], [0, 60]];  // single closed polygon, 32 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
