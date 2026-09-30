$fn = 32;

// ----------------------------------------------------------------------
// Arc stop: segment, 14 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 14;      // extrusion height
profile_points = 17;      // points of the closed outline

profile = [[38, 0], [36.871, 9.193], [33.552, 17.84], [28.254, 15.023], [25.604, 19.194], [22.344, 22.908], [18.55, 26.075], [14.314, 28.62], [9.737, 30.483], [4.927, 31.618], [0, 32], [0, 20], [6.18, 19.021], [11.756, 16.18], [16.18, 11.756], [19.021, 6.18], [20, 0]];  // single closed polygon, 17 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
