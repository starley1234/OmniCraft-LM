$fn = 32;

// ----------------------------------------------------------------------
// Oversize slot bar: 180 mm bar with 3 oversize windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 32;      // points of the closed outline

profile = [[0, 4], [1.172, 1.172], [4, 0], [176, 0], [178.828, 1.172], [180, 4], [180, 50], [147.75, 50], [147.75, 45], [150.75, 45], [150.75, 28], [119.25, 28], [119.25, 45], [122.25, 45], [122.25, 50], [102.75, 50], [102.75, 45], [105.75, 45], [105.75, 28], [74.25, 28], [74.25, 45], [77.25, 45], [77.25, 50], [57.75, 50], [57.75, 45], [60.75, 45], [60.75, 28], [29.25, 28], [29.25, 45], [32.25, 45], [32.25, 50], [0, 50]];  // single closed polygon, 32 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
