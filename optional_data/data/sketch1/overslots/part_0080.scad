$fn = 32;

// ----------------------------------------------------------------------
// Oversize slot bar: 120 mm bar with 3 oversize windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 32;      // points of the closed outline

profile = [[0, 4], [1.172, 1.172], [4, 0], [116, 0], [118.828, 1.172], [120, 4], [120, 40], [96.5, 40], [96.5, 37], [100.5, 37], [100.5, 18], [79.5, 18], [79.5, 37], [83.5, 37], [83.5, 40], [66.5, 40], [66.5, 37], [70.5, 37], [70.5, 18], [49.5, 18], [49.5, 37], [53.5, 37], [53.5, 40], [36.5, 40], [36.5, 37], [40.5, 37], [40.5, 18], [19.5, 18], [19.5, 37], [23.5, 37], [23.5, 40], [0, 40]];  // single closed polygon, 32 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
