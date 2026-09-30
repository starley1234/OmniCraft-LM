$fn = 32;

// ----------------------------------------------------------------------
// Flat adaptor: hex_disc, 10 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 14;      // points of the closed outline

profile = [[0, 19.499], [1.981, 10.821], [4, 3.499], [15.55, 0], [24.45, 0], [36, 3.499], [38.019, 10.821], [40, 19.499], [38.019, 28.176], [36, 35.499], [24.45, 38.997], [15.55, 38.997], [4, 35.499], [1.981, 28.176]];  // single closed polygon, 14 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
