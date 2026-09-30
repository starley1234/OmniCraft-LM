$fn = 32;

// ----------------------------------------------------------------------
// Cam disc: base radius 15.0 mm, lift 12.0 mm, 24 profile points
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[42, 22.733], [41.686, 26.668], [40.687, 30.635], [38.849, 34.582], [36, 38.322], [32.033, 41.518], [27, 43.733], [21.163, 44.518], [15, 43.518], [9.151, 40.582], [4.313, 35.831], [1.117, 29.668], [0, 22.733], [1.117, 15.798], [2.365, 8.51], [5.969, 1.702], [13.875, 0], [21.163, 0.949], [27, 1.733], [32.033, 3.949], [36, 7.145], [38.849, 10.884], [40.687, 14.831], [41.686, 18.798]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
