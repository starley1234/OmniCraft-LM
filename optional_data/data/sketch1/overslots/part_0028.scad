$fn = 32;

// ----------------------------------------------------------------------
// Oversize slot bar: 120 mm bar with 3 oversize windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 32;      // points of the closed outline

profile = [[0, 4], [1.172, 1.172], [4, 0], [116, 0], [118.828, 1.172], [120, 4], [120, 50], [96.5, 50], [96.5, 45], [100.5, 45], [100.5, 24], [79.5, 24], [79.5, 45], [83.5, 45], [83.5, 50], [66.5, 50], [66.5, 45], [70.5, 45], [70.5, 24], [49.5, 24], [49.5, 45], [53.5, 45], [53.5, 50], [36.5, 50], [36.5, 45], [40.5, 45], [40.5, 24], [19.5, 24], [19.5, 45], [23.5, 45], [23.5, 50], [0, 50]];  // single closed polygon, 32 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
