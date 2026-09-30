$fn = 32;

// ----------------------------------------------------------------------
// Chain sprocket: 8 teeth, 14 mm root radius
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 16;      // points of the closed outline

profile = [[35.273, 18.556], [43.221, 25.733], [33.431, 29.112], [33.976, 39.806], [24.664, 35.273], [17.488, 43.221], [14.109, 33.431], [3.415, 33.976], [7.947, 24.664], [0, 17.488], [9.79, 14.109], [9.244, 3.415], [18.556, 7.947], [25.733, 0], [29.112, 9.79], [39.806, 9.244]];  // single closed polygon, 16 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
