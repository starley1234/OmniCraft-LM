$fn = 32;

// ----------------------------------------------------------------------
// Chain sprocket: 10 teeth, 18 mm root radius
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 20;      // points of the closed outline

profile = [[39.472, 18.557], [43.501, 25.012], [37.94, 29.575], [37.404, 37.165], [30.223, 37.588], [25.328, 43.414], [19.27, 39.535], [11.886, 41.372], [9.265, 34.673], [2.211, 31.818], [4.028, 24.858], [0, 18.402], [5.561, 13.839], [6.097, 6.249], [13.278, 5.826], [18.172, 0], [24.231, 3.879], [31.615, 2.043], [34.236, 8.742], [41.289, 11.596]];  // single closed polygon, 20 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
