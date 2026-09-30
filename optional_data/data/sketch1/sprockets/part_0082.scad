$fn = 32;

// ----------------------------------------------------------------------
// Chain sprocket: 9 teeth, 30 mm root radius
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 18;      // points of the closed outline

profile = [[62.584, 26.652], [66.887, 36.741], [59.444, 46.932], [56.256, 57.426], [44.004, 60.449], [34.816, 66.439], [23.487, 60.879], [12.599, 59.561], [7.494, 48.02], [0, 40.012], [3.508, 27.89], [2.915, 16.938], [13.394, 9.907], [19.98, 1.136], [32.527, 2.486], [43.209, 0], [51.953, 9.099], [61.734, 14.061]];  // single closed polygon, 18 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
