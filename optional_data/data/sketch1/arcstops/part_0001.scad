$fn = 32;

// ----------------------------------------------------------------------
// Arc stop: segment, 12 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 12;      // extrusion height
profile_points = 17;      // points of the closed outline

profile = [[35.055, 0], [34.608, 6.402], [33.273, 12.679], [27.506, 11.025], [25.678, 16.087], [23.187, 20.857], [20.078, 25.25], [16.408, 29.186], [12.243, 32.594], [7.658, 35.411], [2.736, 37.588], [0, 30.07], [6.95, 26.529], [12.836, 21.412], [17.31, 15.023], [20.105, 7.742], [21.055, 0]];  // single closed polygon, 17 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
