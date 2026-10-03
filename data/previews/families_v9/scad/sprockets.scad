$fn = 32;
// ----------------------------------------------------------------------
// Chain sprocket: 9 teeth, 14 mm root radius
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 18;      // points of the closed outline

profile = [[32.261, 15.431], [37.378, 20.532], [30.796, 24.895], [31.437, 32.091], [23.591, 31.203], [19.456, 37.128], [14.016, 31.403], [7.04, 33.284], [6.553, 25.403], [0, 22.36], [4.693, 16.008], [1.629, 9.465], [9.306, 7.616], [11.165, 0.635], [18.235, 4.153], [24.146, 0], [27.3, 7.24], [34.499, 7.858]];  // single closed polygon, 18 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
