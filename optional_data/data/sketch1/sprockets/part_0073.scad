$fn = 32;

// ----------------------------------------------------------------------
// Chain sprocket: 11 teeth, 14 mm root radius
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 22;      // points of the closed outline

profile = [[31.521, 15.756], [35.605, 19.833], [30.533, 23.582], [31.764, 29.22], [25.47, 29.632], [23.458, 35.04], [17.94, 31.984], [13.323, 35.445], [10.334, 29.891], [4.579, 30.307], [5.067, 24.019], [0, 21.257], [3.811, 16.231], [1.041, 11.169], [6.964, 9], [7.371, 3.244], [13.526, 4.622], [16.981, 0], [21.414, 4.487], [26.819, 2.466], [28.122, 8.638], [33.762, 9.86]];  // single closed polygon, 22 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
