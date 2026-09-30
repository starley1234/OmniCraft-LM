$fn = 32;

// ----------------------------------------------------------------------
// Cam disc: base radius 20.0 mm, lift 8.0 mm, 20 profile points
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 14;      // extrusion height
profile_points = 20;      // points of the closed outline

profile = [[48, 24.071], [47.207, 30.312], [44.798, 36.275], [40.725, 41.585], [35.034, 45.721], [28, 48.071], [20.202, 48.072], [12.511, 45.389], [5.966, 40.08], [1.557, 32.663], [0, 24.071], [1.487, 15.456], [4.039, 6.662], [11.111, 0.825], [20.179, 0], [28, 0.071], [35.034, 2.421], [40.725, 6.556], [44.798, 11.866], [47.207, 17.83]];  // single closed polygon, 20 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
