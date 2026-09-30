$fn = 32;

// ----------------------------------------------------------------------
// Oversize slot bar: 180 mm bar with 3 oversize windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 32;      // points of the closed outline

profile = [[0, 4], [1.172, 1.172], [4, 0], [176, 0], [178.828, 1.172], [180, 4], [180, 60], [149, 60], [149, 57], [153, 57], [153, 34], [117, 34], [117, 57], [121, 57], [121, 60], [104, 60], [104, 57], [108, 57], [108, 34], [72, 34], [72, 57], [76, 57], [76, 60], [59, 60], [59, 57], [63, 57], [63, 34], [27, 34], [27, 57], [31, 57], [31, 60], [0, 60]];  // single closed polygon, 32 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
