$fn = 32;

// ----------------------------------------------------------------------
// Chain sprocket: 10 teeth, 22 mm root radius
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 20;      // points of the closed outline

profile = [[51.575, 25.298], [59.83, 31.409], [49.702, 38.765], [52.788, 48.561], [40.27, 48.559], [37.01, 58.298], [26.883, 50.939], [18.521, 56.901], [14.654, 44.996], [4.385, 44.904], [8.254, 32.999], [0, 26.889], [10.128, 19.532], [7.041, 9.737], [19.559, 9.739], [22.82, 0], [32.946, 7.359], [41.308, 1.397], [45.175, 13.302], [55.445, 13.394]];  // single closed polygon, 20 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
