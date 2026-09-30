$fn = 32;

// ----------------------------------------------------------------------
// Chain sprocket: 10 teeth, 26 mm root radius
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 20;      // points of the closed outline

profile = [[55.258, 25.05], [59.319, 34.107], [53.044, 40.966], [51.006, 50.68], [41.898, 52.54], [34.539, 59.201], [26.077, 55.353], [16.208, 56.416], [11.625, 48.329], [3.015, 43.388], [4.061, 34.151], [0, 25.094], [6.275, 18.236], [8.313, 8.521], [17.421, 6.661], [24.78, 0], [33.242, 3.849], [43.111, 2.785], [47.695, 10.873], [56.304, 15.813]];  // single closed polygon, 20 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
