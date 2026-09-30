$fn = 32;

// ----------------------------------------------------------------------
// Arc stop: segment, 8 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 17;      // points of the closed outline

profile = [[30.476, 0], [29.347, 9.193], [26.028, 17.84], [20.73, 15.023], [19.005, 17.894], [16.989, 20.569], [14.705, 23.019], [12.177, 25.216], [9.433, 27.138], [6.503, 28.761], [3.42, 30.07], [0, 20.673], [4.778, 18.239], [8.825, 14.721], [11.9, 10.328], [13.822, 5.322], [14.476, 0]];  // single closed polygon, 17 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
