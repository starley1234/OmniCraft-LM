$fn = 32;

// ----------------------------------------------------------------------
// Chain sprocket: 8 teeth, 14 mm root radius
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 16;      // points of the closed outline

profile = [[35.443, 18.727], [43.561, 24.88], [33.601, 29.282], [34.99, 39.374], [24.835, 35.443], [18.681, 43.561], [14.279, 33.601], [4.187, 34.99], [8.118, 24.835], [0, 18.681], [9.96, 14.279], [8.571, 4.187], [18.727, 8.118], [24.88, 0], [29.282, 9.96], [39.374, 8.571]];  // single closed polygon, 16 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
