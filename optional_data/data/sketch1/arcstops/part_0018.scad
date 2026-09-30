$fn = 32;

// ----------------------------------------------------------------------
// Arc stop: segment, 14 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 14;      // extrusion height
profile_points = 17;      // points of the closed outline

profile = [[46, 0], [45.155, 8.777], [42.65, 17.232], [37.087, 14.984], [34.027, 21.027], [29.991, 26.467], [25.095, 31.149], [19.48, 34.936], [13.305, 37.722], [6.749, 39.426], [0, 40], [0, 34], [10.507, 32.336], [19.985, 27.507], [27.507, 19.985], [32.336, 10.507], [34, 0]];  // single closed polygon, 17 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
