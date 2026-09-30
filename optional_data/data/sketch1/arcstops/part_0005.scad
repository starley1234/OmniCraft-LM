$fn = 32;

// ----------------------------------------------------------------------
// Arc stop: segment, 8 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 17;      // points of the closed outline

profile = [[36, 0], [34.931, 8.709], [31.786, 16.901], [28.254, 15.023], [25.604, 19.194], [22.344, 22.908], [18.55, 26.075], [14.314, 28.62], [9.737, 30.483], [4.927, 31.618], [0, 32], [0, 22], [6.798, 20.923], [12.931, 17.798], [17.798, 12.931], [20.923, 6.798], [22, 0]];  // single closed polygon, 17 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
