$fn = 32;

// ----------------------------------------------------------------------
// Arc stop: segment, 8 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 17;      // points of the closed outline

profile = [[25.844, 0], [24.893, 7.742], [22.098, 15.023], [16.8, 12.206], [15.399, 14.539], [13.761, 16.712], [11.905, 18.703], [9.851, 20.488], [7.622, 22.049], [5.241, 23.369], [2.736, 24.432], [0, 16.914], [3.909, 14.923], [7.22, 12.044], [9.737, 8.45], [11.309, 4.355], [11.844, 0]];  // single closed polygon, 17 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
