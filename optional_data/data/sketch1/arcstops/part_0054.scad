$fn = 32;

// ----------------------------------------------------------------------
// Arc stop: segment, 10 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 17;      // points of the closed outline

profile = [[58.569, 0], [58.199, 5.289], [57.097, 10.474], [51.33, 8.82], [47.622, 17.093], [41.743, 23.993], [34.165, 28.968], [25.496, 31.618], [16.432, 31.731], [7.7, 29.298], [0, 24.513], [6.428, 16.853], [15.247, 21.347], [25.143, 21.519], [34.114, 17.336], [40.343, 9.644], [42.569, 0]];  // single closed polygon, 17 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
