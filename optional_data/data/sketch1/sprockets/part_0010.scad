$fn = 32;

// ----------------------------------------------------------------------
// Chain sprocket: 9 teeth, 18 mm root radius
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 18;      // points of the closed outline

profile = [[43.011, 21.341], [51.149, 28.096], [41.127, 33.509], [43.019, 43.914], [31.863, 41.619], [26.624, 50.806], [19.553, 41.877], [9.634, 45.547], [9.957, 34.162], [0, 30.597], [7.566, 22.083], [2.229, 12.953], [13.497, 11.294], [15.278, 0.869], [24.977, 6.841], [33.042, 0], [36.633, 10.809], [47.209, 10.753]];  // single closed polygon, 18 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
