$fn = 32;

// ----------------------------------------------------------------------
// Chain sprocket: 9 teeth, 30 mm root radius
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 18;      // points of the closed outline

profile = [[66.484, 30.474], [74.756, 41.063], [63.345, 50.753], [62.874, 64.182], [47.904, 64.27], [38.912, 74.255], [27.388, 64.7], [14.081, 66.569], [11.395, 51.841], [0, 44.719], [7.409, 31.711], [3.258, 18.931], [17.295, 13.728], [22.33, 1.27], [36.427, 6.307], [48.293, 0], [55.854, 12.92], [68.997, 15.716]];  // single closed polygon, 18 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
