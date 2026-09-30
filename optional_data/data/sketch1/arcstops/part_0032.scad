$fn = 32;

// ----------------------------------------------------------------------
// Arc stop: segment, 10 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 17;      // points of the closed outline

profile = [[42.893, 0], [42.562, 4.732], [41.575, 9.372], [33.885, 7.167], [31.538, 12.775], [27.952, 17.684], [23.324, 21.627], [17.907, 24.387], [11.997, 25.814], [5.917, 25.829], [0, 24.432], [2.736, 16.914], [9.521, 17.989], [16.214, 16.444], [21.841, 12.504], [25.582, 6.743], [26.893, 0]];  // single closed polygon, 17 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
