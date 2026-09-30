$fn = 32;

// ----------------------------------------------------------------------
// Chain sprocket: 8 teeth, 18 mm root radius
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 16;      // points of the closed outline

profile = [[39.469, 17.976], [43.805, 23.973], [37.1, 31.547], [35.926, 38.854], [25.829, 39.469], [19.832, 43.805], [12.257, 37.1], [4.951, 35.926], [4.336, 25.829], [0, 19.832], [6.704, 12.257], [7.879, 4.951], [17.976, 4.336], [23.973, 0], [31.547, 6.704], [38.854, 7.879]];  // single closed polygon, 16 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
