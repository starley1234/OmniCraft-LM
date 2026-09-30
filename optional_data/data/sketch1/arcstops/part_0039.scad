$fn = 32;

// ----------------------------------------------------------------------
// Arc stop: segment, 14 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 14;      // extrusion height
profile_points = 17;      // points of the closed outline

profile = [[36, 0], [35.339, 6.869], [33.379, 13.486], [29.67, 11.987], [27.222, 16.822], [23.993, 21.174], [20.076, 24.919], [15.584, 27.949], [10.644, 30.178], [5.4, 31.541], [0, 32], [0, 24], [7.416, 22.825], [14.107, 19.416], [19.416, 14.107], [22.825, 7.416], [24, 0]];  // single closed polygon, 17 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
