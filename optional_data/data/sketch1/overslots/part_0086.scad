$fn = 32;

// ----------------------------------------------------------------------
// Oversize slot bar: 180 mm bar with 3 oversize windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 32;      // points of the closed outline

profile = [[0, 4], [1.172, 1.172], [4, 0], [176, 0], [178.828, 1.172], [180, 4], [180, 60], [148, 60], [148, 57], [153, 57], [153, 38], [117, 38], [117, 57], [122, 57], [122, 60], [103, 60], [103, 57], [108, 57], [108, 38], [72, 38], [72, 57], [77, 57], [77, 60], [58, 60], [58, 57], [63, 57], [63, 38], [27, 38], [27, 57], [32, 57], [32, 60], [0, 60]];  // single closed polygon, 32 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
