$fn = 32;

// ----------------------------------------------------------------------
// Arc stop: segment, 8 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 17;      // points of the closed outline

profile = [[58.569, 0], [58.199, 5.289], [57.097, 10.474], [51.33, 8.82], [47.622, 17.093], [41.743, 23.993], [34.165, 28.968], [25.496, 31.618], [16.432, 31.731], [7.7, 29.298], [0, 24.513], [5.142, 18.385], [14.763, 23.287], [25.559, 23.476], [35.345, 18.912], [42.14, 10.521], [44.569, 0]];  // single closed polygon, 17 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
