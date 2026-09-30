$fn = 32;

// ----------------------------------------------------------------------
// Chain sprocket: 9 teeth, 30 mm root radius
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 18;      // points of the closed outline

profile = [[64.837, 28.087], [70.904, 39.918], [61.698, 48.367], [58.741, 61.329], [46.257, 61.884], [35.66, 69.913], [25.741, 62.314], [12.461, 61.653], [9.748, 49.455], [0, 40.413], [5.762, 29.324], [4.107, 16.132], [15.648, 11.342], [22.86, 0.172], [34.78, 3.921], [47.485, 0], [54.207, 10.534], [66.459, 15.697]];  // single closed polygon, 18 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
