$fn = 32;

// ----------------------------------------------------------------------
// Chain sprocket: 10 teeth, 18 mm root radius
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 20;      // points of the closed outline

profile = [[40.657, 19.197], [45.869, 24.08], [39.124, 30.216], [40.471, 37.23], [31.407, 38.229], [28.374, 44.695], [20.454, 40.176], [14.2, 43.624], [10.449, 35.313], [3.362, 34.427], [5.212, 25.498], [0, 20.615], [6.745, 14.479], [5.398, 7.465], [14.462, 6.466], [17.495, 0], [25.415, 4.519], [31.67, 1.071], [35.42, 9.382], [42.508, 10.269]];  // single closed polygon, 20 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
