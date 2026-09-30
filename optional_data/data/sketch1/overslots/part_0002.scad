$fn = 32;

// ----------------------------------------------------------------------
// Oversize slot bar: 180 mm bar with 3 oversize windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 32;      // points of the closed outline

profile = [[0, 4], [1.172, 1.172], [4, 0], [176, 0], [178.828, 1.172], [180, 4], [180, 50], [148, 50], [148, 45], [153, 45], [153, 20], [117, 20], [117, 45], [122, 45], [122, 50], [103, 50], [103, 45], [108, 45], [108, 20], [72, 20], [72, 45], [77, 45], [77, 50], [58, 50], [58, 45], [63, 45], [63, 20], [27, 20], [27, 45], [32, 45], [32, 50], [0, 50]];  // single closed polygon, 32 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
