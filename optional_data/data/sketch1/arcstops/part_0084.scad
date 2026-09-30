$fn = 32;

// ----------------------------------------------------------------------
// Arc stop: segment, 14 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 14;      // extrusion height
profile_points = 17;      // points of the closed outline

profile = [[29.107, 0], [27.979, 9.193], [24.659, 17.84], [19.362, 15.023], [17.637, 17.894], [15.621, 20.569], [13.337, 23.019], [10.809, 25.216], [8.065, 27.138], [5.135, 28.761], [2.052, 30.07], [0, 24.432], [5.646, 21.555], [10.429, 17.397], [14.064, 12.206], [16.335, 6.29], [17.107, 0]];  // single closed polygon, 17 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
