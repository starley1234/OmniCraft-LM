$fn = 32;

// ----------------------------------------------------------------------
// Cam disc: base radius 20.0 mm, lift 12.0 mm, 20 profile points
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 14;      // extrusion height
profile_points = 20;      // points of the closed outline

profile = [[52, 23.124], [51.231, 29.373], [49.448, 35.801], [46.292, 42.795], [40.555, 49.455], [32, 53.558], [22.18, 53.348], [13.191, 49.013], [6.111, 41.933], [1.566, 33.013], [0, 23.124], [1.776, 13.304], [7.379, 5.236], [15.727, 0.726], [24.486, 0], [32, 1.558], [38.249, 3.893], [43.756, 6.944], [48.18, 11.368], [51.021, 16.944]];  // single closed polygon, 20 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
