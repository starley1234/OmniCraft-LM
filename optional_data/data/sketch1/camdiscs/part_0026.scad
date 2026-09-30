$fn = 32;

// ----------------------------------------------------------------------
// Cam disc: base radius 13.0 mm, lift 12.0 mm, 22 profile points
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 22;      // points of the closed outline

profile = [[38, 16.858], [37.634, 20.568], [36.955, 24.541], [35.775, 29.294], [33.087, 34.566], [28.178, 38.964], [21.552, 40.84], [14.639, 39.546], [8.628, 35.752], [3.969, 30.374], [1.013, 23.902], [0, 16.858], [1.173, 9.862], [4.987, 3.997], [10.891, 0.575], [17.301, 0], [22.77, 1.35], [26.96, 3.227], [30.425, 4.98], [33.513, 7.034], [35.936, 9.83], [37.473, 13.196]];  // single closed polygon, 22 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
