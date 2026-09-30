$fn = 32;

// ----------------------------------------------------------------------
// Chain sprocket: 9 teeth, 30 mm root radius
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 18;      // points of the closed outline

profile = [[64.169, 28.979], [70.614, 37.818], [61.03, 49.258], [60.285, 60.172], [45.589, 62.775], [38.003, 70.657], [25.073, 63.205], [14.195, 64.367], [9.08, 50.346], [0, 44.244], [5.094, 30.216], [2.061, 19.705], [14.98, 12.233], [19.413, 2.232], [34.112, 4.812], [43.937, 0], [53.539, 11.426], [64.158, 14.054]];  // single closed polygon, 18 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
