$fn = 32;

// ----------------------------------------------------------------------
// Chain sprocket: 9 teeth, 22 mm root radius
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 18;      // points of the closed outline

profile = [[48.601, 22.798], [54.922, 29.414], [46.299, 37.67], [46.888, 46.801], [34.976, 47.582], [29.558, 54.956], [19.931, 47.897], [11.04, 50.063], [8.202, 38.468], [0, 34.412], [5.279, 23.705], [1.603, 15.326], [12.529, 10.518], [15.099, 1.736], [26.56, 5.076], [34.173, 0], [40.806, 9.926], [49.901, 10.931]];  // single closed polygon, 18 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
