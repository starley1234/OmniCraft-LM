$fn = 32;

// ----------------------------------------------------------------------
// Oversize slot bar: 180 mm bar with 2 oversize windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 4], [1.172, 1.172], [4, 0], [176, 0], [178.828, 1.172], [180, 4], [180, 50], [137, 50], [137, 45], [141, 45], [141, 20], [99, 20], [99, 45], [103, 45], [103, 50], [77, 50], [77, 45], [81, 45], [81, 20], [39, 20], [39, 45], [43, 45], [43, 50], [0, 50]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
